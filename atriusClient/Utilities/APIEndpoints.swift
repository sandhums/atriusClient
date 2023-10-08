//
//  APIEndpoints.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 07/10/23.
//

import Foundation

struct APIEndpoints {
    private static let baseUrlPath = "http://127.0.0.1:3000/api/v1"
    
    struct URLs {
        static let signup = URL(string: "\(baseUrlPath)/users/signup")!
        static let login = URL(string: "\(baseUrlPath)/users/login")!
    }
}
