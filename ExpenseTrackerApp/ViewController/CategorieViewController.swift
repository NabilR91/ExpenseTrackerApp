//
//  CategorieViewController.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 18.01.23.
//

import UIKit

var selectedCategorie = ""
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
        return 10
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
            cell.icon?.image = UIImage (systemName: "iphone")
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
        }
        else if indexPath.row == 5{
            cell.categorie?.text = "Verkauf"
            cell.icon?.image = UIImage(systemName: "dollarsign.arrow.circlepath")
        }
        else if indexPath.row == 6{
            cell.categorie?.text = "Gesundheit"
            cell.icon?.image = UIImage(systemName: "figure.run.circle")
        }
        else if indexPath.row == 7{
            cell.categorie?.text = "Lifestyle"
            cell.icon?.image = UIImage(systemName: "tshirt")
        }
        else if indexPath.row == 8{
            cell.categorie?.text = "Einkommen"
            cell.icon?.image = UIImage(systemName: "bolt")
        }
        else if indexPath.row == 9{
            cell.categorie?.text = "Alles"
            cell.icon?.image = UIImage(systemName: "poweroff")
            
        }
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            selectedCategorie = "Entertainment"
        }
        else if indexPath.row == 1{
            selectedCategorie = "Handy"
        }
        else if indexPath.row == 2{
            selectedCategorie = "Freizeit"
        }
        else if indexPath.row == 3{
            selectedCategorie = "Reisen"
        }
        else if indexPath.row == 4{
            selectedCategorie = "Wohnen"
        }
        else if indexPath.row == 5{
            selectedCategorie = "Verkauf"
        }
        else if indexPath.row == 6{
            selectedCategorie = "Gesundheit"
        }
        else if indexPath.row == 7{
            selectedCategorie = "Lifestyle"
        }
        else if indexPath.row == 8{
            selectedCategorie = "Einkommen"
        }
        else if indexPath.row == 9{
            selectedCategorie = ""
        }
    }
    
}


