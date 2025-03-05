//
//  FirebaseManager.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-02-19.
//

import Foundation
import FirebaseCore
import FirebaseAuth

/*
 class FirebaseManager {
 static let shared = FirebaseManager()
 
 private init() {}
 
 // Login with Authentication
 func login(user: UserModel, completion: @escaping (Result<User, Error>) -> Void) {
 Auth.auth().signIn(withEmail: user.email, password: user.password) { authResult, error in
 if let error = error {
 completion(.failure(error))
 }
 else if let user = authResult?.user {
 completion(.success(user))
 }
 }
 }
 }
 */

class AuthManager : ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var isAuthenticated = false
    
    init(){
        self.user = Auth.auth().currentUser
        self.isAuthenticated = (self.user != nil)
    }
    
    func login(user: UserModel, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) {result, error in
            DispatchQueue.main.async {
                if let error = error{
                    self.errorMessage = error.localizedDescription
                    completion(false)
                } else {
                    self.user = result?.user
                    self.isAuthenticated = true
                    completion(true)
                }
            }
        }
    }
    
    func register(user: UserModel, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(false)
                } else {
                    self.user = result?.user
                    self.isAuthenticated = true
                    completion(true)
                }
            }
        }
    }
    
    func logout(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.user = nil
                self.isAuthenticated = false 
                completion(true)
            }
        } catch let error {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                completion(false)
            }
        }
    }

}
