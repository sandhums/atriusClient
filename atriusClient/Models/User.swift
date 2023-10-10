//
//  User.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 07/10/23.
//

import Foundation

struct User: Codable {
    var id: String? {
        return _id
    }
    var _id: String
    var name: String
    var email: String
    var password: String
    var photo: String?
    var role: String?
    var active: Bool?
    var passwordChangedAt: Date?
    var passwordResetToken: String?
    var passwordResetExpires: Date?
    
}
struct ApiResponse: Codable {
    var user: User
    var token: String
}
