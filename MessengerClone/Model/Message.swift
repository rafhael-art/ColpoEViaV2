//
//  Message.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 16/11/23.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Message:Identifiable, Codable, Hashable {
    @DocumentID var messageId :String?
    let fromId:String
    let toId:String
    let messageTest :String
    let timestamp : Timestamp
    var user : User?
    
    var id : String {
        return messageId ?? NSUUID().uuidString
    }
    
    var chatParnerId : String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
    var isFromCurrentUser : Bool {
        return fromId == Auth.auth().currentUser?.uid
    }
    
    var timestampString : String {
        return timestamp.dateValue().timestampString()
    }
}
