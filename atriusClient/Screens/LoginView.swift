//
//  LoginView.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 07/10/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var model: AtriusModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    private func login() async {
        do {
            let signupDTO =  try await model.login(email: email, password: password)
            
            //            if loginResponseDTO.error {
            //                //errorMessage = loginResponseDTO.reason ?? ""
            //                appState.errorWrapper = ErrorWrapper(error: AppError.login, guidance: loginResponseDTO.reason ?? "")
            //            } else {
            //                appState.routes.append(.home)
            //            }
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
            }
            Text(errorMessage)
        }
    }
}

#Preview {
    LoginView()
}
