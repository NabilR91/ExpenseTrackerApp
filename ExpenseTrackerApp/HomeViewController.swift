//
//  HomeTableViewController.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 16.01.23.
//

import UIKit
import CoreData


class HomeViewController: UIViewController{
    
    @IBOutlet weak var tableview:UITableView!
    var expenses = [Expense]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //     Hier den Code schreiben das die Daten neu aus CoreData geladen werden, immer wenn die View geöffnet wird.
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Expense")
        do {
            expenses = try managedContext.fetch(fetchRequest) as! [Expense]
            tableview.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
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

