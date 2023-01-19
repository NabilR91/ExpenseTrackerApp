//
//  HomeTableViewCell.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 16.01.23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var betreff: UILabel!
    @IBOutlet weak var datum: UILabel!
    @IBOutlet weak var betrag: UILabel!
    @IBOutlet weak var icon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
