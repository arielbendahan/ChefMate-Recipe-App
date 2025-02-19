//
//  FirebaseManager.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-02-19.
//

import Foundation
import FirebaseCore
import FirebaseAuth

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
