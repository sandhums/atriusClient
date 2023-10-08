//
//  User.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 07/10/23.
//

import Foundation

class User: Codable {
//    var _id: String
    var name: String
    var email: String
    var password: String
    var role: String
    var active: Bool
    
    init(name: String, email: String, password: String, role: String, active: Bool) {
        self.name = name
        self.email = email
        self.password = password
        self.role = role
        self.active = active
    }
}
