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

    var body: some Scene {
        WindowGroup {
//            SignupView().onAppear(){
//                print("app folder path is \(NSHomeDirectory())")
//            }
            if model.keychainToken == nil {
                LoginView()
                    .environmentObject(model)
                  
            } else {
                ContentView()
                    .environmentObject(model)
            }
                
        }
    }
}
