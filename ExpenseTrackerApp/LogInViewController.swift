//
//  LogInViewController.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 24.01.23.
//

import UIKit
import CoreData


class LogInViewController: UIViewController {

@IBOutlet weak var emailTextField: UITextField!
@IBOutlet weak var passwordTextField: UITextField!
@IBOutlet weak var loginButton: UIButton!

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

override func viewDidLoad() {
    super.viewDidLoad()
    
}

@IBAction func loginButtonTapped(_ sender: Any) {
    // Validiert die InputFelder
    if (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
        let alert = UIAlertController(title: "Error", message: "Please fill in all fields.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
    }

    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    request.predicate = NSPredicate(format: "email = %@", emailTextField.text!)
    request.returnsObjectsAsFaults = false

    do {
        let result = try context.fetch(request)
        if result.count > 0 {
            for data in result as! [NSManagedObject] {
                if passwordTextField.text == data.value(forKey: "password") as? String {
                    // Navigiert zum HomeScreen
                    
                    data.setValue(true, forKey: "isLoggedIn")
                    print(data.value(forKey: "isLoggedIn"))
                    let homeViewController = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                    self.present(homeViewController, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: "Incorrect email or password.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Incorrect email or password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    } catch {
        print("Error fetching data")
    }
}
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let registeredUser = checkForRegisteredUser()

        if registeredUser != nil {
            // Benutzer registriert, direkt zum Homescreen wechseln
           checkIfUserDataExist()
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }

    func checkForRegisteredUser() -> User? {
        // erställt den Fetch Request
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        // Führt den Fetch Request durch
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            let users = try managedContext.fetch(fetchRequest)
            if !users.isEmpty {
                return users.first
            } else {
                return nil
            }
        } catch {
            print("Unable to fetch registered user: \(error.localizedDescription)")
            return nil
        }
    }
//    zeigt im Log an ob und welcher User angemeldet ist
    func checkIfUserDataExist() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.isEmpty {
                print("No data found in Core Data")
            } else {
                for data in result as! [NSManagedObject] {
                    print(data.value(forKey: "firstName") as! String)
                    print(data.value(forKey: "email") as! String)
                }
            }
        } catch {
            print("Failed")
        }
    }



}
