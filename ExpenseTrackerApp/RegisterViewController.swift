import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet var alreadyRegisteredLabel: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        // Validate input fields
        if (firstNameTextField.text?.isEmpty)! || (lastNameTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (repeatPasswordTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Fehler", message: "Bitte füllen Sie alle Felder aus.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        // Validate passwords match
        if passwordTextField.text != repeatPasswordTextField.text {
            let alert = UIAlertController(title: "Fehler", message: "Die Passwörter stimmen nicht überein.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        // Save user to Core Data
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        newUser.setValue(firstNameTextField.text, forKey: "firstName")
        newUser.setValue(lastNameTextField.text, forKey: "lastName")
        newUser.setValue(emailTextField.text, forKey: "email")
        newUser.setValue(passwordTextField.text, forKey: "password")
        newUser.setValue(true, forKey: "isLoggedIn")
        do {
            try context.save()
            print("User saved")
        } catch {
            print("Error saving user")
        }
        // Navigate to home screen
        let homeViewController = self.storyboard?.instantiateViewController(identifier: "TabBarCon") as! UITabBarController
        self.present(homeViewController, animated: true, completion: nil)
    }
    
}
