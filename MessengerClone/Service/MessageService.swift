//
//  MessageService.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 16/11/23.
//

import Foundation
import Firebase


struct MessageService {
    
    static let messageCollection = Firestore.firestore().collection("messages")
    
    static func sendMessage(_ messageText : String, toUser user : User){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = user.id
        
        let currentUserRef = messageCollection.document(currentUid).collection(chatPartnerId).document()
        let chatpartnerRef = messageCollection.document(chatPartnerId).collection(currentUid)
        
        let messageId = currentUserRef.documentID
        
        let message = Message(messageId:messageId, fromId: currentUid, toId: chatPartnerId, messageTest: messageText, timestamp: Timestamp())
        
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        
        currentUserRef.setData(messageData)
        chatpartnerRef.document(messageId).setData(messageData)
    }
    
    static func observeMessages(chatPartner : User, completion : @escaping ([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        print("DEBUG : currentUid \(currentUid)")
         let chatPartnerId = chatPartner.id
        print("DEBUG : currentUid \(chatPartnerId)")
        let query = messageCollection.document(currentUid).collection(chatPartnerId).order(by: "timestamp", descending: false)
         
         query.addSnapshotListener{ snapshot, _ in
             guard let changes = snapshot?.documentChanges.filter({ $0.type == .added}) else { return }
             var messages = changes.compactMap({ try? $0.document.data(as: Message.self)})
             
             for ( index , message ) in messages.enumerated() where message.fromId != currentUid{
                 messages[index].user = chatPartner
             }
             completion(messages)
         }
         
         
    }
}
