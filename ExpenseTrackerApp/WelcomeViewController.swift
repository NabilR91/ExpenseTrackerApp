//
//  WelcomeViewController.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 25.01.23.
//

import UIKit
import CoreData

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var signUpWithEmailButton: UIButton!
    @IBOutlet weak var signUpWithAppleButton: UIButton!
    @IBOutlet weak var signUpWithGoogleButton: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        checkLogIn()
        
        signUpWithEmailButton.addTarget(self, action: #selector(signUpWithEmailButtonTapped), for: .touchUpInside)
        logInBtn.addTarget(self, action: #selector(logInBtnTap), for: .touchUpInside)
    }
    @objc func logInBtnTap() {
        let loginViewController = self.storyboard?.instantiateViewController(identifier: "LogInViewController") as! LogInViewController
        self.navigationController?.pushViewController(loginViewController, animated: true)    }
    
    @objc func signUpWithEmailButtonTapped() {
        let registerViewController = self.storyboard?.instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    
    func checkLogIn(){
        //        Überprüfen ob User eingeloggt ist. Falls ja zum HomeViewController navigieren
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
//        request.predicate = NSPredicate(format: "isLoggedIn = %@", true)
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for i in 0...results.count-1{
                    let user = results[i] as! User
                    if (user.isLoggedIn){
                        currentUser = user
                        let homeViewController = self.storyboard?.instantiateViewController(identifier: "TabBarCon") as! UITabBarController
                        self.present(homeViewController, animated: true, completion: nil)
                    }
                }
            }
        } catch let error as NSError {
            print("Could not fetch: \(error), \(error.userInfo)")
        }
        
        
            
            
//            let homeViewController = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
//            self.present(homeViewController, animated: true, completion: nil)
            
    }
    
}


