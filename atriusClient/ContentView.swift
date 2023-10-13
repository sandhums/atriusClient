//
//  ContentView.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 07/10/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var model: AtriusModel
    @EnvironmentObject private var appState: AppState
    
//    private func redirect() {
//        if (model.userRole == "doctor") {
//            appState.routes.append(.doctor)
//        } else  if (model.userRole == "patient") {
//            appState.routes.append(.patient)
//        } else {
//        appState.routes.append(.home)
//            }
//        }
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
        }
//        .onAppear(perform: {
//            redirect()
//        })
        .navigationTitle("Home")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Logout") {
                    model.logout()
                    appState.routes.append(.login)
                }
            }
        }
        .padding()
        
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .environmentObject(AtriusModel())
            .environmentObject(AppState())
    }
}
