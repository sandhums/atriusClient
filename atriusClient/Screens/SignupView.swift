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
    @StateObject private var viewModel = AuthEntryModel()
//    @State private var name: String = ""
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var passwordConfirm: String = ""
    @State private var errorMessage: String = ""
    
    private func signup() async {
        do {
            let authResponse = try await model.signup(name: viewModel.name, email: viewModel.email, password: viewModel.password, passwordConfirm: viewModel.confirmPw)
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
            EntryField(sfSymbolName: "envelope", placeholder: "Full Name", prompt: viewModel.namePrompt, field: $viewModel.name)
            EntryField(sfSymbolName: "envelope", placeholder: "Email Address", prompt: viewModel.emailPrompt, field: $viewModel.email)
            EntryField(sfSymbolName: "lock", placeholder: "Password", prompt: viewModel.passwordPrompt, field: $viewModel.password, isSecure: true)
            EntryField(sfSymbolName: "lock", placeholder: "Confirm Password", prompt: viewModel.confirmPwPrompt, field: $viewModel.confirmPw, isSecure: true)
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
