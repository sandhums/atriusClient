//
//  signupDTO.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 07/10/23.
//

import Foundation

public struct SignupDTO: Codable {
    
    public let error: Bool
    public var reason: String? = nil
    public var token: String? = nil
//    public var userId: String? = nil
    
    public init(error: Bool, reason: String? = nil, token: String? = nil) {
        self.error = error
        self.reason = reason
        self.token = token
      
    }
}

struct LoginResponse: Codable {
    var status: String?
    var token: String?
    var message: String?
}

struct AuthResponse: Codable {
    var status: String = ""
    var token: String? = ""
    var message: String? = ""
    var user: UserResponse?
}
struct UserResponse: Codable {
    var _id: String? = ""
    var name: String? = ""
    var email: String? = ""
    var role: String? = ""
    var active: Bool? = false
}
    
//    private enum AuthResponseKeys: String, CodingKey {
//        case status
//        case token
//        case message
//        case user
//    }
    
//    private enum DataKeys: String, CodingKey {
//        case user
//    }
    
//    private enum UserKeys: String, CodingKey {
//        case _id
//        case name
//        case email
//        case role
//        case active
//    }
    
//    init(from decoder: Decoder) throws {
//        if let authResponseContainer = try? decoder.container(keyedBy: AuthResponseKeys.self) {
//            self.status = try authResponseContainer.decode(String.self, forKey: .status)
//            self.token = try authResponseContainer.decode(String.self, forKey: .token)
//            self.message = try authResponseContainer.decode(String.self, forKey: .message)
//            
//            if let userContainer = try? authResponseContainer.nestedContainer(keyedBy: UserKeys.self, forKey: .user){
//               
//                    self._id = try userContainer.decode(String.self, forKey: ._id)
//                    self.name = try userContainer.decode(String.self, forKey: .name)
//                    self.email = try userContainer.decode(String.self, forKey: .email)
//                    self.role = try userContainer.decode(String.self, forKey: .role)
//                    self.active = try userContainer.decode(Bool.self, forKey: .active)
//                
//            }
//            
//        }
//        
//    }


