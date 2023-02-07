//
//  NewsViewController.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 20.01.23.
//

import UIKit

class NewsViewController: UIViewController {
    
    var url = URL(string: "https://newsapi.org/v2/everything?q=wallstreet&language=en&sortBy=publishedAt&apiKey=76fa3fdda479423d960b6a312dc96880")
    
    @IBOutlet weak var tableView: UITableView!

    var article = [Articles]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchData{data in self.article = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
       
    }
    
    func fetchData(completion: @escaping([Articles])->()){
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: {data, response, error in
            guard let data = data, error == nil else{
             print("error")
                return
            
                }
                let decoder = JSONDecoder()
            var result: Data?
            do {
                result = try decoder.decode(Data.self, from: data)
                print (result!.articles)
                completion(result!.articles)
            } catch{
                print("error \(error)")
            }
            }
        )
        dataTask.resume()
    }
    
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return article.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as!
        NewsTableViewCell
        cell.layer.cornerRadius = 10
        cell.titel?.text = article[indexPath.row].title
        cell.titel.lineBreakMode = .byTruncatingTail
        cell.titel.adjustsFontSizeToFitWidth = false
        cell.review?.text = article[indexPath.row].description
        let myDate = article[indexPath.row].publishedAt
              let index = myDate.index(myDate.startIndex, offsetBy: 10)
        let mySubstring = myDate[..<index]
        cell.date?.text = String(mySubstring)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
   
}
