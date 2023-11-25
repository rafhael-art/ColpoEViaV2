//
//  ContentViewModel.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 8/11/23.
//

import Foundation
import FirebaseAuth
import Combine

class ContentViewModel: ObservableObject {
    @Published var userSession : FirebaseAuth.User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubcribers()
    }
    
    private func setupSubcribers(){
        AuthService.shared.$userSession.sink{ [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancellables)
    }
}
