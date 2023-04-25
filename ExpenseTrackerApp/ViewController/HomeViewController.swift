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
        self.navigationController?.navigationBar.isHidden = false
        
        
        
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
        let euroTF = String(updateIncome())
        let euroTF2 = String(updateExpense())
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
        // Hier wird überprüft ob der wert isIncome true oder false ist und jeh nachdem wird der Text in TableV rot oder grün angezeigt
            let expense = expenses[indexPath.row]
            if expense.isIncome == false {
                cell.betrag?.textColor = .red
            } else {
                cell.betrag?.textColor = .green
            }
        cell.betreff?.text = expenses[indexPath.row].category
        cell.datum?.text = expenses[indexPath.row].date
        cell.betrag?.text = expenses[indexPath.row].amount.description
        if expenses[indexPath.row].category == "Wohnen" {
            cell.icon?.image = UIImage(systemName: "house")
        }
        // Hier wird die Kategorie überprüft und das entsprechende icon gesetzt
            switch expense.category {
            case "Entertainment":
                cell.icon?.image = UIImage(systemName: "tv")
            case "Handy":
                cell.icon?.image = UIImage(systemName: "iphone")
            case "Freizeit":
                cell.icon?.image = UIImage(systemName: "gamecontroller")
            case "Reisen":
                cell.icon?.image = UIImage(systemName: "airplane")
            case "Wohnen":
                cell.icon?.image = UIImage(systemName: "house")
            case "Verkauf":
                cell.icon?.image = UIImage(systemName: "dollarsign.arrow.circlepath")
            case "Gesundheit":
                cell.icon?.image = UIImage(systemName: "figure.run.circle")
            case "Lifestyle":
                cell.icon?.image = UIImage(systemName: "tshirt")
            case "Einkommen":
                cell.icon?.image = UIImage(systemName: "bolt")
            default:
                cell.imageView?.image = nil
            }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
}

