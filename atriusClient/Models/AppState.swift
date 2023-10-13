//
//  AppState.swift
//  clientApp
//
//  Created by Manjinder Sandhu on 17/09/23.
//

import Foundation

enum AppError: Error {
    case register
    case login
    case notLoggedIn
    case badResponse
}

enum Route: Hashable {
    case login
    case signup
    case home
    case patient
    case doctor
    case billing
    
}

class AppState: ObservableObject{
    @Published var routes: [Route] = []
    @Published var errorWrapper: ErrorWrapper?
}
