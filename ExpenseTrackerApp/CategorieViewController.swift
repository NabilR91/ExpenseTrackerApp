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
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCell(withIdentifier: "categorieCell", for: indexPath) as! CategorieTableViewCell
        cell.categorie?.text = "Entertainment"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
