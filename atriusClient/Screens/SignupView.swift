//
//  SignupView.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 07/10/23.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject private var model: AtriusModel
    @EnvironmentObject private var appState: AppState
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    @State private var errorMessage: String = ""
    
    private func signup() async {
        do {
            let authResponse = try await model.signup(name: name, email: email, password: password, passwordConfirm: passwordConfirm)
            if authResponse.status == "success"{
                appState.routes.append(.home)
            } else {
                appState.errorWrapper = ErrorWrapper(error: AppError.login, guidance: authResponse.message ?? "")
            }

        } catch {
            appState.errorWrapper = ErrorWrapper(error: AppError.login, guidance: error.localizedDescription)
        }

    }
    var body: some View {
        Form {
            TextField("name", text: $name)
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            SecureField("Confirm Password", text: $passwordConfirm)

            Button("Signup"){
                Task {
                    await signup()
                }
            }.buttonStyle(.borderless)
            Text(errorMessage)
        }
    }
}

#Preview {
    SignupView()
}
