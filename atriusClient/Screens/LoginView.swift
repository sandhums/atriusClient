//
//  LoginView.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 07/10/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var model: AtriusModel
    @EnvironmentObject private var appState: AppState
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    private func login() async {
        do {
            let signupDTO =  try await model.login(email: email, password: password)
            appState.routes.append(.home)
//            if signupDTO.status == "success" {
//           
//                
//            //            if loginResponseDTO.error {
//            //                //errorMessage = loginResponseDTO.reason ?? ""
//                          
//                        } else {
//                            appState.errorWrapper = ErrorWrapper(error: AppError.login, guidance: "incorrect email or password")
//                        }
        } catch {
            errorMessage = error.localizedDescription
            //            appState.errorWrapper = ErrorWrapper(error: error, guidance: error.localizedDescription)
        }
    }
    var body: some View {
        Form {
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
           SecureField("Password", text: $password)
            
            HStack {
                Button("Login"){
                    Task {
                        await login()
                    }
                }.buttonStyle(.borderless)
                Spacer()
                Button("Register"){
                    appState.routes.append(.signup)
                }.buttonStyle(.borderless)
            }
        }
        .navigationTitle("Login")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
