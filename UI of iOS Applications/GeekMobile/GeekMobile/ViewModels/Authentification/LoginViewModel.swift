//
//  LoginViewModel.swift
//  ClientVK
//
//  Created by Egor on 27.02.2021.
//

import Foundation

protocol LoginViewModelProtocol {
    var passwordTip: String { get }
    func handlePasswordChanged(_ password: String)
    func isAccessGranted(login: String, password: String) -> Bool
    var loginButtonEnabled: Bool { get set }
    var loginButtonEnabledChanged: ((Bool) -> ())? { get set }
}


class LoginViewModel: LoginViewModelProtocol {
    
    // Properties
    private let model: LoginModel
    var passwordTip: String {
        return model.passwordReqs
    }
    var loginButtonEnabled: Bool = false {
        didSet {
            loginButtonEnabledChanged?(loginButtonEnabled)
        }
    }
    var loginButtonEnabledChanged: ((Bool) -> ())?
    
    // Initializers
    init(model: LoginModel) {
        self.model = model
    }
    
    // Methods
    func handlePasswordChanged(_ password: String) {
        loginButtonEnabled = model.isPasswordValid(password)
    }
    
    func isAccessGranted(login: String, password: String) -> Bool {
        return login == model.adminUsername && password == model.adminPassword
    }
}
