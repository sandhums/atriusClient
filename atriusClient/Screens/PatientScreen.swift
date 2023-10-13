//
//  PatientScreen.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 11/10/23.
//

import SwiftUI

struct PatientScreen: View {
    
    @EnvironmentObject private var model: AtriusModel
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        Text("Patient Screen")
    }
}

#Preview {
    NavigationStack {
        PatientScreen()
    }
}
