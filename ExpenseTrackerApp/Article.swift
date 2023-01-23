//
//  Article.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 23.01.23.
//

import Foundation

struct Data: Codable {
    var articles:[Articles]

}

struct Articles: Codable {
    var title: String
    var url: String
    var urlToImage: String
    var content: String
}

