//
//  WelcomeViewController.swift
//  ExpenseTrackerApp
//
//  Created by Nabil Reimer on 25.01.23.
//

import UIKit

class WelcomeViewController: UIViewController {

@IBOutlet weak var signUpWithEmailButton: UIButton!
@IBOutlet weak var signUpWithAppleButton: UIButton!
@IBOutlet weak var signUpWithGoogleButton: UIButton!
    @IBOutlet weak var logInBtn: UIButton!

override func viewDidLoad() {
    super.viewDidLoad()
    
//    IF Abfrage if eingeloggt dann den unteren code ausführen
    
//    let homeViewController = self.storyboard?.instantiateViewController(identifier: "TabBarCon") as! UITabBarController
//    self.present(homeViewController, animated: true, completion: nil)
    
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
}

