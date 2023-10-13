//
//  DoctorScreen.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 11/10/23.
//

import SwiftUI

struct DoctorScreen: View {
    
    @EnvironmentObject private var model: AtriusModel
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        Text("Doctor Screen")
            .navigationTitle("Doctors")
            .navigationBarBackButtonHidden(true)
    }
        
}

#Preview {
    NavigationStack {
        DoctorScreen()
            .environmentObject(AtriusModel())
            .environmentObject(AppState())
    }
}
