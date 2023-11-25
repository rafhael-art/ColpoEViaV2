//
//  ProfileView.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 4/11/23.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    let user: User
       @StateObject var viewModel: ProfileViewModel
    @Environment(\.dismiss) var dismiss
       init(user: User) {
           self.user = user
           _viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
       }
    var body: some View {
        VStack{
            //header
            VStack{
                PhotosPicker(selection: $viewModel.selectedItem){
                    if let profileImage = viewModel.profileImage{
                        profileImage
                            .resizable()
                            .frame(width: 80,height: 80)
                            .foregroundColor(Color(.systemGray4))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    } else {
                        CircularImageView(user: user, size: .xLarge)
                    }
                }
                
                
                
                Text(user.fullname)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            List{
                Section{
                    ForEach(SettingsOptionsViewModel.allCases){ option in
                        
                        HStack{
                            Image(systemName: option.imageName)
                                .resizable()
                                .frame(width: 24,height: 24)
                                .foregroundColor(option.imageBackgroundColor)
                            Text(option.title)
                                .font(.subheadline)
                        }
                        
                    }
                }
                
                Section{
                    Button("Log Out"){
                        AuthService.shared.singOut()
                    }
                    
                    Button("Delete Account"){
                        
                    }
                }
                .foregroundColor(.red)
                
                Section{
                    Button("Save Changes"){
                        Task { try await viewModel.updateUserData()}
                        dismiss()
                    }
                    
                }
                .foregroundColor(.blue)
            }
            
        }
    }
}

#Preview {
    ProfileView( user: User.MOCK_USER)
}
