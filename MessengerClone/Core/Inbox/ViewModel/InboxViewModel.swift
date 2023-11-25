//
//  InboxViewModel.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 13/11/23.
//

import Foundation
import Combine
import Firebase

class InboxViewModel : ObservableObject{
    
    @Published var currentUser : User?
    @Published var recentMessages = [Message]()
    
    private var cancellables = Set<AnyCancellable>()
    private let service = InboxService()
    
    init(){
        setupSubscribers()
        service.observableRecentmessages()
    }
    
    func setupSubscribers(){
        UserService.shared.$currentUser.sink{ [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
        
        service.$documentChanges.sink{ [weak self] changes in
            self?.loadinitialMessages(fromChages: changes)
        }.store(in: &cancellables)
    }
    
    private func loadinitialMessages( fromChages changes : [DocumentChange]) {
        var messages = changes.compactMap( { try? $0.document.data(as: Message.self)} )
        for i in 0 ..< messages.count {
            let message = messages[i]
            UserService.fetchUser(withUid: message.chatParnerId) { user in
                messages[i].user = user
                self.recentMessages.append(messages[i])
            }
        }
    }
    
   
    
}
