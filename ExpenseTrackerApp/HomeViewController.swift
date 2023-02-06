//
//  HomeTableViewController.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 16.01.23.
//

import UIKit
import CoreData


class HomeViewController: UIViewController{
    
    @IBOutlet weak var gesamtAusgaben: UILabel!
    @IBOutlet weak var gesamtEinnahmen: UILabel!
    @IBOutlet weak var gesamtSaldo: UILabel!
    @IBOutlet weak var tableview:UITableView!
    
    
    var expenses = [Expense]()
    var allIncome: [Expense] = []
    var allExpense: [Expense] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.layer.cornerRadius = 30
        tableview.layer.masksToBounds = true
        self.navigationController?.navigationBar.isHidden = true
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //     Hier den Code schreiben das die Daten neu aus CoreData geladen werden, immer wenn die View geöffnet wird.
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Expense")
        
        
        //Hier ist der Code für die Filter funktion, wo man im categorieView die HomeView filtern kann
        if selectedCategorie != ""{
            let predicate = NSPredicate(format: "category == %@ AND userEmail == %@", selectedCategorie, currentUser!.email!)
            fetchRequest.predicate = predicate
        }else{
            let predicate = NSPredicate(format: "userEmail == %@", currentUser!.email!)
            fetchRequest.predicate = predicate
        }
        do {
            expenses = try managedContext.fetch(fetchRequest) as! [Expense]
            tableview.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        getAllIncome()
        getAllExpenses()
        
        // Hier ist der Code für die gesamtEinnahmen ausgabe einnahme
        var euroTF = String(updateIncome())
        var euroTF2 = String(updateExpense())
        gesamtEinnahmen.text = euroTF+" €"
        gesamtAusgaben.text = euroTF2+" €"
        gesamtSaldo.text = String(Double(euroTF)!-Double(euroTF2)!)+" €"
    }
    
    func getAllIncome(){
        allIncome = []
        for i in expenses where i.isIncome {
            allIncome.append(i)
        }
    }
    
    func getAllExpenses(){
        allExpense = []
        for i in expenses where i.isIncome == false{
            allExpense.append(i)
        }
    }
    
    func updateIncome() -> Double{
        var result = 0.0
        for i in allIncome {
            result += i.amount
        }
        return result
    }
    func updateExpense() -> Double{
        var resultExpense = 0.0
        for i in allExpense{
            resultExpense += i.amount
        }
        return resultExpense
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.betreff?.text = expenses[indexPath.row].category
        cell.datum?.text = expenses[indexPath.row].date
        cell.betrag?.text = expenses[indexPath.row].amount.description
        if expenses[indexPath.row].category == "Wohnen" {
            cell.icon?.image = UIImage(systemName: "house")
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
}

