//
//  InboxService.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 21/11/23.
//

import Foundation
import Firebase

class InboxService {
    @Published var documentChanges = [DocumentChange]()
    
    func observableRecentmessages () {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = FirestoreConstants.MessagesCollection.document(uid).collection("recent-messages").order(by: "timestamp" ,descending: true)
        
        query.addSnapshotListener{ snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added || $0.type == .modified}) else { return }
            self.documentChanges = changes
        }
        
        
    }
}
