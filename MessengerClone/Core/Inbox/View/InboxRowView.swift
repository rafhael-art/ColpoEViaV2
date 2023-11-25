//
//  InboxRowView.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 31/10/23.
//

import SwiftUI

struct InboxRowView: View {
    let message : Message
    var body: some View {
        HStack(alignment : .top,spacing: 12){
            CircularImageView(user: message.user, size: .medium)
            VStack(alignment : .leading, spacing: 4){
                Text(message.user?.fullname ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(message.messageTest)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100 , alignment: .leading)
            }
            
            HStack{
                Text(message.timestampString)
                
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
       
        .frame(height: 72)
    }
}

 
