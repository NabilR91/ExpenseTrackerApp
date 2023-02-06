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
//    var url: URL
//    var urlToImage: URL
    var content: String
//    var description: String
    var publishedAt: String
}

