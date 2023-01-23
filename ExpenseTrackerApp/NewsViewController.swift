//
//  NewsViewController.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 20.01.23.
//

import UIKit

class NewsViewController: UIViewController {
    
    var url = URL(string: "https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=76fa3fdda479423d960b6a312dc96880")
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var topNews: UIImageView!
    var article = [Articles]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        topNews.layer.cornerRadius = 30
        topNews.clipsToBounds = true
        fetchData{data in self.article = data}
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
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as!
        NewsTableViewCell
        cell.titel?.text = "Spitzenmanager widersprechen Scholz und fordern Reformagenda für Europa"
        cell.review?.text = "Europa hat die tiefe Wirtschaftskrise vermieden, doch für neues Wachstum fehlen der Wirtschaft zufolge Impulse. CEOs machen in Davos Vorschläge."
        cell.date?.text = "19.01.2023"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
   
}
