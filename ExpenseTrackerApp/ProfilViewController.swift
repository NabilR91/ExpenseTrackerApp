//
//  ProfilViewController.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 30.01.23.
//

import UIKit
import CoreData

class ProfilViewController: UIViewController {
    
    @IBOutlet weak var labelFullName: UILabel!
     @IBOutlet weak var labelEmail: UILabel!
    
    
    
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
        
        
        let navigationController = self.storyboard?.instantiateViewController(identifier: "NavigationController") as! UINavigationController
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hier werden die BenutzerDaten des angemeldeten Users im ProfilScreen angezeigt
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            request.returnsObjectsAsFaults = false
            do {
              let result = try context.fetch(request)
              for data in result as! [NSManagedObject] {
                if let firstName = data.value(forKey: "firstName") as? String,
                   let lastName = data.value(forKey: "lastName") as? String {
                  labelFullName.text = firstName + " " + lastName
                }
                if let email = data.value(forKey: "email") as? String {
                  labelEmail.text = email
                }
              }
            } catch {
              print("Failed")
            }
          }
        }
