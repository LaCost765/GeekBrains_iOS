//
//  LoginViewController.swift
//  ClientVK
//
//  Created by Egor on 27.02.2021.
//

import UIKit

class LoginViewController: UIScrollableViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTipLabel: UILabel!
    
    
    var viewModel: LoginViewModel = LoginViewModel(model: LoginModel())

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = viewModel.loginButtonEnabled
        passwordTipLabel.text = viewModel.passwordTip
        viewModel.loginButtonEnabledChanged = { [unowned self] (enabled) in
            self.loginButton.isEnabled = enabled
        }
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: Any) {
        viewModel.handlePasswordChanged(passwordTextField.text ?? "")
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if viewModel.isAccessGranted(login: username, password: password) {
            let story = UIStoryboard(name: "Main", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "MainTabBar")
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            // create the alert
            let alert = UIAlertController(title: "Error", message: "Неверные данные учетной записи администратора", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
}


