//
//  ChatViewModel.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 16/11/23.
//

import Foundation

class ChatViewModel : ObservableObject {
    @Published var messageText = ""
    @Published var messages = [Message]()
    
    
    let service : ChatService
    
    init(user:User){
        self.service = ChatService(chatPartner: user)
        observeMessages()
    }
    
    func sendMessage(){
        service.sendMessage(messageText)
    }
    
    func observeMessages(){
        service.observeMessages() { messages in
            self.messages.append(contentsOf: messages)
        }
    }
}
