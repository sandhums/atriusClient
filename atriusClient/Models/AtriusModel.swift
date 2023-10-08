//
//  AtriusModel.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 07/10/23.
//

import Foundation

class AtriusModel: ObservableObject {
    @Published private(set) var isLoggedIn = false
    
    let httpClient = HTTPClient()
    
    init() {
//        if keychainToken != nil {
//            self.isLoggedIn = true
//        }
        let token = getStoredToken()
        if token != nil {
            self.isLoggedIn = true
        }
    }
//    var keychainToken: String? {
//        get { getStoredToken()
//        }
//        set {
//            if let newToken = newValue {
//                updateStoredToken(newToken)
//            }
//        }
//    }
    
    func signup(name: String, email: String, password: String, passwordConfirm: String) async throws -> SignupDTO {
        
        // MARK: TODO - create a separate model/struct for register/logindata request
        let signupData = ["name": name, "email": email, "password": password, "passwordConfirm": passwordConfirm]
        let resource = try Resource(url: APIEndpoints.URLs.signup, method: .post(JSONEncoder().encode(signupData)), modelType: SignupDTO.self)
        let signupDTO = try await httpClient.load(resource)
        let token = signupDTO.token
        updateStoredToken(token)
        return signupDTO
    }
    
    func login(email: String, password: String) async throws -> SignupDTO {
        
        let loginPostData = ["email": email, "password": password]
        
        // resource
        let resource = try Resource(url: APIEndpoints.URLs.login, method: .post(JSONEncoder().encode(loginPostData)), modelType: SignupDTO.self)
        
        let signupDTO = try await httpClient.load(resource)
        let token = signupDTO.token
        
        updateStoredToken(token)
        
        return signupDTO
    }
    
    func logout() {
//        keychainToken = nil
        deleteStoredToken()
        self.isLoggedIn = false
    }
    
    
    func updateStoredToken(_ token: String) {
        let kcw = KeychainWrapperForToken()
        do {
            try kcw.storeGenericTokenFor(
                account: "Atrius",
                service: "jwtToken",
                token: token)
        } catch let error as KeychainWrapperError {
            print("Exception storing token: \(error.message ?? "no message")")
        } catch {
            print("An error occurred storing the token.")
        }
        
    }
    
    func getStoredToken() -> String? {
        let kcw = KeychainWrapperForToken()
        if let token = try? kcw.getGenericTokenFor(
            account: "Atrius",
            service: "jwtToken") {
            print(token)
            return token
        }
            print("error getting token")
            return ""
    }
    
    func deleteStoredToken() {
        let kcw = KeychainWrapperForToken()
        if let token = try? kcw.deleteGenericTokenFor(
            account: "Atrius",
            service: "jwtToken"){
            
        }
    }
    
}
