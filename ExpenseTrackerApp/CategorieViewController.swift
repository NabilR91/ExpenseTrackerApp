//
//  CategorieViewController.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 18.01.23.
//

import UIKit

class CategorieViewController: UIViewController {
    
    @IBOutlet weak var tableview:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
    }
}

extension CategorieViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCell(withIdentifier: "categorieCell", for: indexPath) as! CategorieTableViewCell
        
        if indexPath.row == 0{
            cell.categorie?.text = "Entertainment"
            cell.icon?.image = UIImage (systemName: "tv")
        }
        else if indexPath.row == 1{
            cell.categorie?.text = "Handy"
            cell.icon?.image = UIImage (systemName: "house")
        }
        else if indexPath.row == 2{
            cell.categorie?.text = "Freizeit"
            cell.icon?.image = UIImage(systemName: "gamecontroller")
        }
        else if indexPath.row == 3{
            cell.categorie?.text = "Reisen"
            cell.icon?.image = UIImage(systemName: "airplane")
        }
        else if indexPath.row == 4{
            cell.categorie?.text = "Wohnen"
            cell.icon?.image = UIImage(systemName: "house")
            
            return cell
        }
        else if indexPath.row == 5{
            cell.categorie?.text = "Essen"
            cell.icon?.image = UIImage(systemName: "fork.knife")
            
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70
        }
    }
}
