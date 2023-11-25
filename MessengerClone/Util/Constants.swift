//
//  Constants.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 16/11/23.
//

import Foundation
import Firebase

struct FirestoreConstants {
    static let UserCollection = Firestore.firestore().collection("users")
    static let MessagesCollection = Firestore.firestore().collection("messages")
}
