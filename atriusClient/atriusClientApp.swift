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
                    if model.isLoggedIn {
                            ContentView()
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
                    }
                }
            }
            .environmentObject(model)
            .environmentObject(appState)
        }
    }
}
