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
            let loginResponse =  try await model.login(email: email, password: password)
       
            if loginResponse.status == "success"{
                appState.routes.append(.home)
            } else {
                appState.errorWrapper = ErrorWrapper(error: AppError.login, guidance: "Incorrect email or password")
            }

        } catch {
            appState.errorWrapper = ErrorWrapper(error: AppError.login, guidance: "Incorrect email or password")
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
            Text(errorMessage)
        }
        .navigationTitle("Login")
        .navigationBarBackButtonHidden(true)
        .sheet(item: $appState.errorWrapper) { errorWrapper in
            ErrorView(errorWrapper: errorWrapper)
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(AtriusModel())
            .environmentObject(AppState())
    }
}
