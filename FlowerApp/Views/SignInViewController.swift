import UIKit

class SignInViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        AuthServices.authChanged { (auth, user) in
            /// present flowers view contoller
            if user != nil{
                let main = UIStoryboard(name: "Main", bundle: nil)
                let flowersVc = main.instantiateViewController(withIdentifier: "flowerslist")
                self.navigationController?.pushViewController(flowersVc, animated: true)
            }
        }
    }
    
    @IBAction func signInbtn_DidTapped(_ sender: UIButton) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text
            else {
                self.showAlert(title: "Sign in Error", message: "please fill all fields")
                return
        }
        AuthServices.signIn(email: email, password: password) { (errorMessage) in
            self.showAlert(title: "Sign in Error", message: errorMessage)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
