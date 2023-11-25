//
//  User.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 5/11/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User : Codable, Identifiable, Hashable {
    @DocumentID var uid: String?
    let fullname : String
    let email : String
    var profileImageUrl: String?
    var id: String{
        return uid ?? NSUUID().uuidString
    }
    
    var firstName : String {
        let fomatter = PersonNameComponentsFormatter()
        let components = fomatter.personNameComponents(from:  fullname)
        return components?.givenName ?? fullname
    }
}

extension User {
    static let MOCK_USER = User(fullname: "Bruce Wayne", email: "batman@gmail.com", profileImageUrl: "batman")
}
