//
//  Route.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 23/11/23.
//

import Foundation

enum Route : Hashable {
    case profile(User)
    case chatView(User)
}
