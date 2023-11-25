//
//  LoginViewModel.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 7/11/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func login() async throws {
 
        try await AuthService.shared.login(withEmail: email, password: password)
    }
    
}
