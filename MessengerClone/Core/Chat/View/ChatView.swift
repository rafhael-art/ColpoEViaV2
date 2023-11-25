//
//  ChatView.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 5/11/23.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel : ChatViewModel
    let user :User
    
    init(user: User){
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            ScrollView{
                //header
                
                VStack{
                    CircularImageView(user: user, size: .xLarge)
                    
                    VStack (spacing : 4) {
                        Text(user.fullname)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("messenger")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                //Messages
                LazyVStack{
                    ForEach(viewModel.messages){message in
                        ChatMessageCell(message: message)
                    }
                }
            }
            //Messages input view
            Spacer()
            
            ZStack(alignment : .trailing) {
                TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                Button{
                    viewModel.sendMessage()
                    viewModel.messageText = ""
                }label: {
                    Text("Send")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle(user.fullname)
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

#Preview {
    ChatView(user: .MOCK_USER)
}
