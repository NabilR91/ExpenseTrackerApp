//
//  NewsTableViewCell.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 20.01.23.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var titel: UILabel!
    @IBOutlet weak var review: UITextView!
    @IBOutlet weak var date: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
