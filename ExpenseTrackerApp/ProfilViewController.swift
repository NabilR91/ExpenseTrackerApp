//
//  ProfilViewController.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 30.01.23.
//

import UIKit
import CoreData

class ProfilViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let welcomeViewController = segue.destination as? WelcomeViewController{
            welcomeViewController.modalPresentationStyle = .fullScreen
        }
    }
    
    
    func logOut() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                let user = results[0] as! User
                user.isLoggedIn = false
                
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Could not log out: \(error), \(error.userInfo)")
                }
            }
        } catch let error as NSError {
            print("Could not fetch: \(error), \(error.userInfo)")
        }
    }

    
    @IBAction func logOutBtn(_ sender: Any) {
        logOut()
        
//       let welcomeViewController = self.storyboard?.instantiateViewController(identifier: "welcomeViewController") as! WelcomeViewController
//      self.present(welcomeViewController, animated: true, completion: nil)
//        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

   

}
