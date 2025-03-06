//
//  FirebaseManager.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-02-19.
//

import Foundation
import FirebaseCore
import FirebaseAuth

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
                if let error = error as NSError?{
                    switch error.code {
                    case AuthErrorCode.invalidCredential.rawValue:
                        self.errorMessage = "Incorrect email or password. Please try again"
                    default:
                        self.errorMessage = error.localizedDescription
                    }
                    completion(false)
                } else {
                    self.user = result?.user
                    self.isAuthenticated = true
                    print("Login successful")
                    completion(true)
                }
            }
        }
    }
    
    func register(user: UserModel, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
            DispatchQueue.main.async {
                if let error = error as NSError?{
                    switch error.code {
                    case AuthErrorCode.invalidEmail.rawValue:
                        self.errorMessage = "Email not in correct format."
                    case AuthErrorCode.emailAlreadyInUse.rawValue:
                        self.errorMessage = "Email already in use. Please enter another email"
                    case AuthErrorCode.weakPassword.rawValue:
                        self.errorMessage = "Password must be 6 characters or more."
                    default:
                        self.errorMessage = error.localizedDescription
                    }
                    completion(false)
                } else {
                    self.user = result?.user
                    self.isAuthenticated = true
                    print("Register successful")
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
