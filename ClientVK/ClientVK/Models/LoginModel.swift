//
//  LoginDataModel.swift
//  ClientVK
//
//  Created by Egor on 27.02.2021.
//

import Foundation

protocol LoginModelProtocol {
    var username: String? { get set }
    var password: String? { get set }
    var passwordReqs: String { get }
    func isPasswordValid(_ password: String) -> Bool
}

extension LoginModelProtocol {
    var adminUsername: String {
        return "admin"
    }
    var adminPassword: String {
        return "Admin123456"
    }
}

class LoginModel: LoginModelProtocol {
    
    // Properties
    var username: String?
    var password: String?
    var passwordReqs: String {
        return "One big letter, one number, minimum 8 char long"
    }
    
    // Methods
    func isPasswordValid(_ password: String) -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
        
        let result = regex.evaluate(with: password)
        return result
    }
}
