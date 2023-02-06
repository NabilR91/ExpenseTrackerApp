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
        currentUser!.isLoggedIn = false
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not log out: \(error), \(error.userInfo)")
        }
    }
    
    
    @IBAction func logOutBtn(_ sender: Any) {
        logOut()
        
        //        let profilViewController = self.storyboard?.instantiateViewController(identifier: "welcomeViewController") as! WelcomeViewController
        //        self.navigationController?.pushViewController(profilViewController, animated: true)
        let navigationController = self.storyboard?.instantiateViewController(identifier: "NavigationController") as! UINavigationController
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
        
        //       let welcomeViewController = self.storyboard?.instantiateViewController(identifier: "welcomeViewController") as! WelcomeViewController
        //      self.present(welcomeViewController, animated: true, completion: nil)
        //        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    
}
