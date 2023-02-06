//
//  AddScreenViewController.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 26.01.23.
//

import UIKit
import CoreData

class AddScreenViewController: UIViewController {
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var categorieTextField: UITextField!
    let categoriePickerView = UIPickerView()
    @IBOutlet weak var dateTextField: UITextField!
    let datePicker = UIDatePicker()
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var segController: UISegmentedControl!
    
    
    var categorieVC = CategorieViewController()
    var categories: [String] = ["Entertainment","Handy","Freizeit","Reisen","Wohnen","Verkauf","Gesundheit","Lifestyle","Einkommen","Alles"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriePickerView.dataSource = self
        categoriePickerView.delegate = self
        categorieTextField.inputView = categoriePickerView
        categorieTextField.textAlignment = .center
        let toolbarCategory = UIToolbar()
        toolbarCategory.sizeToFit()
        let doneButtonCategory = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedCategory))
        toolbarCategory.setItems([doneButtonCategory], animated: false)
        categorieTextField.inputAccessoryView = toolbarCategory
        
        
        // Hinzufügen des datePickers zum dateTextField
        datePicker.datePickerMode = .date
        dateTextField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        dateTextField.inputAccessoryView = toolbar
        
        
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: datePicker.date)
        dateTextField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    @objc func donePressedCategory() {
        categorieTextField.text = categories[categoriePickerView.selectedRow(inComponent: 0)]
        self.view.endEditing(true)
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        // Bekommt den context
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if segController.selectedSegmentIndex == 0 {
            // Einnahme
            let expense = Expense(context: context)
            expense.amount = Double(amountTextField.text!) ?? 0.0
            expense.category = categorieTextField.text
            expense.date = dateTextField.text
            expense.note = notesTextField.text
            expense.userEmail = currentUser?.email
            expense.isIncome = true
        } else {
            // Ausgabe
            let expense = Expense(context: context)
            expense.amount = Double(amountTextField.text!) ?? 0.0
            expense.category = categorieTextField.text
            expense.date = dateTextField.text
            expense.note = notesTextField.text
            expense.userEmail = currentUser?.email
            expense.isIncome = false
        }
        
        
        
        
        
        
        // Speichert in CoreData
        do {
            try context.save()
        } catch {
            print("Error saving data: \(error)")
        }
        
        
    }
    
    
}

extension AddScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categorieTextField.text = categories[row]
        categorieTextField.resignFirstResponder()
    }
    
    
    
}
