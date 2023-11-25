//
//  ProfileViewModel.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 5/11/23.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var selectedItem : PhotosPickerItem?{
        didSet{Task { try await loadImage() }}
    }
    @Published var user : User
    @Published var profileImage : Image?
   
    
    private var uiImage : UIImage?
    
    init(user : User){ 
        self.user = user
    }
    
    func loadImage() async throws{
        guard let item = selectedItem else { return}
        guard let imagedata = try await item.loadTransferable(type: Data.self) else{return}
        guard let uiImage = UIImage(data: imagedata) else { return}
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        var data = [String : Any]()
        if let uiImage = uiImage {
         let imageUrl = try? await   ProfileService.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        
       
        
        if !data.isEmpty {
            try await FirestoreConstants.UserCollection.document(user.id).updateData(data)
            Task { try await UserService.shared.fetchCurrectUser()}
            
        }
        
    }
}


