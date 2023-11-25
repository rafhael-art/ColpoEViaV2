//
//  ChatMessageCell.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 5/11/23.
//

import SwiftUI

struct ChatMessageCell: View {
    let message : Message
    private var isFromCurrentUser :Bool {
        return message.isFromCurrentUser
    }
    var body: some View {
        HStack{
            if isFromCurrentUser {
                Spacer()
                Text(message.messageTest)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(ChatBouble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
            } else {
                HStack (alignment: .bottom, spacing: 8) {
                    CircularImageView(user: .MOCK_USER, size: .xxSmall)
                    
                    Text(message.messageTest)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .foregroundColor(.black)
                        .clipShape(ChatBouble(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

 
