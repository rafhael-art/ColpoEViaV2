//
//  ActiveViewModel.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 22/11/23.
//

import Foundation
import Firebase

class ActiveViewModel : ObservableObject{
    @Published var users = [User]()
    
    init(){
        Task { try await fetchUsers()}
    }
    
    @MainActor
    private func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAll(limit:10)
        self.users = users.filter({$0.id != currentUid})
    }
}
