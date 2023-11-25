//
//  NewMessageViewModel.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 13/11/23.
//

import Foundation
import Firebase

@MainActor
class NewMessageViewModel : ObservableObject {
    
    @Published var users = [User]()
    
    init() {
        Task{ try await fetchUsers()}
    }
    
    func fetchUsers() async throws {
        guard let curretUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAll()
        self.users = users.filter({$0.id != curretUid})
    }
    
}
