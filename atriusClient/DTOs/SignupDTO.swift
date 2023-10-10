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
    var status: String
    var token: String
}
