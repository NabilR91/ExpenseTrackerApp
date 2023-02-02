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
    @IBOutlet weak var dateTextField: UITextField!
    let datePicker = UIDatePicker()
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var segController: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        //Hinzufügen des DatePickers zum dateTextfield
//        datePicker.datePickerMode = .date
//        dateTextField.inputView = datePicker
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(barButtonSystemItem: <#T##UIBarButtonItem.SystemItem#>, target: <#T##Any?#>, action: <#T##Selector?#>)
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
            expense.isIncome = true
        } else {
            // Ausgabe
            let expense = Expense(context: context)
            expense.amount = Double(amountTextField.text!) ?? 0.0
            expense.category = categorieTextField.text
            expense.date = dateTextField.text
            expense.note = notesTextField.text
            expense.isIncome = false
        }
        
        
        
        
        
        
        // Speichert in CoreData
        do {
            try context.save()
        } catch {
            print("Error saving data: \(error)")
        }
        
//        Navigiert zum HomeScreen
//        let tabBarController = self.tabBarController as! TabBarCon
//        tabBarController.selectedIndex = 0
    }
}


