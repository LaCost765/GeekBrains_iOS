//
//  UserSession.swift
//  GeekMobile
//
//  Created by Egor on 15.04.2021.
//

import Foundation

class UserSession {
    
    static var shared: UserSession = UserSession()
    
    private var vkToken: String?
    private var userID: Int?
    
    private init() {
        
    }
}
