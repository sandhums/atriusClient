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
    var keychainToken: String? 
    
    init() {
        keychainToken = getStoredToken().self
        if keychainToken != "" {
            self.isLoggedIn = true
        }
    }

    func signup(name: String, email: String, password: String, passwordConfirm: String) async throws -> LoginResponse {
        
        // MARK: TODO - create a separate model/struct for register/logindata request
        let signupData = ["name": name, "email": email, "password": password, "passwordConfirm": passwordConfirm]
        let resource = try Resource(url: APIEndpoints.URLs.signup, method: .post(JSONEncoder().encode(signupData)), modelType: LoginResponse.self)
        print("let resource signup")
        let loginResponse = try await httpClient.load(resource)
        print("resource loaded signup")
        let token = loginResponse.token
        updateStoredToken(token)
        return loginResponse
    }
    
    func login(email: String, password: String) async throws -> LoginResponse {
        
        let loginPostData = ["email": email, "password": password]
        
        // resource
        let resource = try Resource(url: APIEndpoints.URLs.login, method: .post(JSONEncoder().encode(loginPostData)), modelType: LoginResponse.self)
        print("let resource")
        let loginResponse = try await httpClient.load(resource)
        print("resource loaded")
        let token = loginResponse.token
        
        updateStoredToken(token)
       
        
        return loginResponse
    }
    
    
    func logout() {
//        keychainToken = nil
        self.isLoggedIn = false
        deleteStoredToken()
        
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
        print("token stored")
    }
    
    func getStoredToken() -> String? {
        let kcw = KeychainWrapperForToken()
        if let token = try? kcw.getGenericTokenFor(
            account: "Atrius",
            service: "jwtToken") {
            print(token)
            keychainToken = token
            return token
        }
            print("error getting token")
            return ""
    }
    
    func deleteStoredToken() {
        let kcw = KeychainWrapperForToken()
        if let _ = try? kcw.deleteGenericTokenFor(
            account: "Atrius",
            service: "jwtToken"){
            print("deleted token")
        }
    }
    
}
