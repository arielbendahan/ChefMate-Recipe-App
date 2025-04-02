//
//  FirebaseManager.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-02-19.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class AuthManager : ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var isAuthenticated = false
    private let db = Firestore.firestore()
    
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
                if let error = error as NSError? {
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
                } else if let firebaseUser = result?.user {
                    self.user = firebaseUser
                    self.isAuthenticated = true
                    
                    // Create a new user document in Firestore with an empty favourites array
                    let newUser = UserModel(id: firebaseUser.uid, email: user.email , firstName: user.firstName , lastName: user.lastName ,password: "")
                    self.saveUserDataToFirebase(user: newUser) { success in
                        if success {
                            print("Register successful and user saved in Firestore")
                        }
                        completion(success)
                    }
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
    
    func saveUserDataToFirebase(user: UserModel, completion: @escaping (Bool) -> Void) {
        db.collection("users").document(user.id).setData([
            "email": user.email,
            "firstName": user.firstName,
            "lastName": user.lastName,
            "favouriteRecipes": []
        ]) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error saving user data: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("User data saved successfully.")
                    completion(true)
                }
            }
        }
    }
    
    func addRecipeToFavorites(recipeId: Int, completion: @escaping (Bool) -> Void) {
        guard let userId = user?.uid else {
            completion(false)
            return
        }
        
        let userRef = db.collection("users").document(userId)
        
        userRef.updateData([
            "favouriteRecipes": FieldValue.arrayUnion([recipeId])
        ]) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error adding favorite: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("Recipe added to favorites.")
                    completion(true)
                }
            }
        }
    }

    func removeRecipeFromFavorites(recipeId: Int, completion: @escaping (Bool) -> Void) {
        guard let userId = user?.uid else {
            completion(false)
            return
        }
        
        let userRef = db.collection("users").document(userId)
        
        userRef.updateData([
            "favouriteRecipes": FieldValue.arrayRemove([recipeId])
        ]) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error removing favorite: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("Recipe removed from favorites.")
                    completion(true)
                }
            }
        }
    }

    func fetchFavoriteRecipes(completion: @escaping ([Int]?) -> Void) {
        guard let userId = user?.uid else {
            completion(nil)
            return
        }
        
        let userRef = db.collection("users").document(userId)
        
        userRef.getDocument { document, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching favorites: \(error.localizedDescription)")
                    completion(nil)
                } else if let document = document, document.exists {
                    let data = document.data()
                    let favorites = data?["favouriteRecipes"] as? [Int] ?? []
                    completion(favorites)
                } else {
                    completion(nil)
                }
            }
        }
    }



}
