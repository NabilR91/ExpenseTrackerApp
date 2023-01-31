//
//  ProfilViewController.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 30.01.23.
//

import UIKit
import CoreData

class ProfilViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let welcomeViewController = segue.destination as? WelcomeViewController{
            welcomeViewController.modalPresentationStyle = .fullScreen
        }
    }
    
    
    func logOut() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if results.count > 0 {
                let user = results[0] as! NSManagedObject
                user.setValue(false, forKey: "isLoggedIn")
                
                do {
                    try managedContext.save()
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
