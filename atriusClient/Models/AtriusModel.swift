//
//  AtriusModel.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 07/10/23.
//

import Foundation

@MainActor
class AtriusModel: ObservableObject {
    @Published private(set) var isLoggedIn = false
    @Published private(set) var userRole = "user"
    
    let httpClient = HTTPClient()
//    var note: [Note] = []
    var note = Note()
    @Published var keychainToken: String? = ""
    
    init() {
        let defaults = UserDefaults.standard
        let userId = defaults.string(forKey: "userId")
        userRole = defaults.string(forKey: "userRole") ?? "user"
        keychainToken = getStoredToken().self
        if keychainToken != nil &&  userId != nil {
            self.isLoggedIn = true
        }
        print(userId as Any)
        print(userRole as Any)
    }

    func signup(name: String, email: String, password: String, passwordConfirm: String) async throws -> AuthResponse {
        
        // MARK: TODO - create a separate model/struct for register/logindata request
        let signupData = ["name": name, "email": email, "password": password, "passwordConfirm": passwordConfirm]
        let resource = try Resource(url: APIEndpoints.URLs.signup, method: .post(JSONEncoder().encode(signupData)), modelType: AuthResponse.self)
        print("let resource signup")
        let authResponse = try await httpClient.load(resource)
        print("resource loaded signup")
        if authResponse.token != nil && authResponse.user?._id != nil {
//        if let token = authResponse.token {
            let defaults = UserDefaults.standard
            defaults.set(authResponse.user?._id, forKey: "userId")
            defaults.set(authResponse.user?.role, forKey: "userRole")
            userRole = authResponse.user?.role ?? "user"
            updateStoredToken(authResponse.token!)
        }
        return authResponse
    }
    
    func login(email: String, password: String) async throws -> AuthResponse {
        
        let loginPostData = ["email": email, "password": password]
        
        // resource
        let resource = try Resource(url: APIEndpoints.URLs.login, method: .post(JSONEncoder().encode(loginPostData)), modelType: AuthResponse.self)
        print("let resource")
        let authResponse = try await httpClient.load(resource)
        print("resource loaded")
        if authResponse.token != nil && authResponse.user?._id != nil {
//        if let token = authResponse.token {
            let defaults = UserDefaults.standard
            defaults.set(authResponse.user?._id, forKey: "userId")
            defaults.set(authResponse.user?.role, forKey: "userRole")
            userRole = authResponse.user?.role ?? "user"
            updateStoredToken(authResponse.token!)
        }
        
        return authResponse
    }
    
    
    func logout() {
        let defaults = UserDefaults.standard
        deleteStoredToken()
        defaults.removeObject(forKey: "userId")
        defaults.removeObject(forKey: "userRole")
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
