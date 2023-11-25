//
//  NewMessageView.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 1/11/23.
//

import SwiftUI

struct NewMessageView: View {
    @State private var searchtext = ""
    @StateObject private var viewModel = NewMessageViewModel()
    @Binding var selectedUser :User?
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            ScrollView{
                TextField("To: ",text: $searchtext )
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                
                Text("CONTANCTS")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .padding()
                
                ForEach(viewModel.users){user in
                    VStack {
                        HStack{
                            CircularImageView(user: user, size: .small)
                            
                            Text(user.fullname)
                                .font(.footnote)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        
                        }
                        .padding(.leading)
                        
                        Divider()
                            .padding(.leading, 40)
                    }
                    .onTapGesture {
                        selectedUser = user
                        dismiss()
                    }
                }
                
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
            }
            
        }
    }
}

#Preview {
    NavigationStack{
        NewMessageView(selectedUser: .constant(User.MOCK_USER))
    }
}
