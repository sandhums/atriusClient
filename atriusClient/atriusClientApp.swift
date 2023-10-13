//
//  atriusClientApp.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 07/10/23.
//

import SwiftUI

@main
struct atriusClientApp: App {
    @StateObject private var model = AtriusModel()
    @StateObject private var appState = AppState()
    

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                Group {
//                    NoteView()
                    if model.isLoggedIn && model.userRole == "doctor" {
                            DoctorScreen()
                    } else if  model.isLoggedIn && model.userRole == "patient" {
                         PatientScreen()
                    } else {
                        LoginView()
                    }
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .login:
                        LoginView()
                    case .signup:
                        SignupView()
                    case .home:
                        ContentView()
                    case .patient:
                        PatientScreen()
                    case .doctor:
                        DoctorScreen()
                    case .billing:
                        BillingScreen()
                    case .note:
                        NoteView()
                    }
                }
            }
            .environmentObject(model)
            .environmentObject(appState)
        }
    }
}
