//
//  AuthService.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 7/11/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthService {
    
    @Published var userSession : FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        loadCurrectUserData()
        print("DEBUG : user sesion id is \(userSession?.uid ?? "")")
    }
    
    @MainActor
    func login(withEmail email: String, password : String ) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession  = result.user
            loadCurrectUserData()
        }catch{
            print("DEBUG : Falied login \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password : String, fullname : String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await self.uploadUserData(email: email, fullname: fullname, id: result.user.uid)
            print("DEBUG : create user \(result.user.uid)")
            loadCurrectUserData()
        } catch {
            print("DEBUG : Falied to create user \(error.localizedDescription)")
        }
    }
    
    func singOut(){
        do{
            try Auth.auth().signOut()
            self.userSession = nil
            UserService.shared.currentUser = nil
        } catch {
            print("DEBUG : Falied logOut \(error.localizedDescription)")
        }
    }
    
    private func uploadUserData(email : String, fullname : String, id:String) async throws{
        let user = User(fullname: fullname, email: email, profileImageUrl: nil)
        
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
        
    }
    
    private func loadCurrectUserData() {
        Task { try await UserService.shared.fetchCurrectUser()}
    }
    
}
