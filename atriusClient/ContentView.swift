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
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
        }
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
    }
}
