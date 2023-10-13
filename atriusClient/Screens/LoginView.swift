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
            let authResponse =  try await model.login(email: email, password: password)
       
            if authResponse.status == "success"{
                appState.routes.append(.home)
//                if (model.userRole == "doctor"){
//                    appState.routes.append(.home)
//                } else if (model.userRole == "patient") {
//                    appState.routes.append(.patient)
//                } else {
//                    appState.routes.append(.billing)
//                }
            } else {
                appState.errorWrapper = ErrorWrapper(error: AppError.login, guidance: authResponse.message ?? "")
            }

        } catch {
//            errorMessage = error.localizedDescription
            appState.errorWrapper = ErrorWrapper(error: AppError.login, guidance: error.localizedDescription)
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
