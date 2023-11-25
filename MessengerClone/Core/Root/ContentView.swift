//
//  ContentView.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 29/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Group{
            if viewModel.userSession != nil{
                InboxView()
            }else{
                Loginview()
            }
        }
    }
}

#Preview {
    ContentView()
}
 
