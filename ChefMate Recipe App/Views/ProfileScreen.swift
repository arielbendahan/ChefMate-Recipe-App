//
//  ProfileScreen.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-03-26.
//

import SwiftUI

struct ProfileScreen: View {
    @StateObject private var authManager = AuthManager()
    @AppStorage("isLoggedIn") private var isLoggedIn = true
    var body: some View {
            VStack {
                HStack {
                    Text("Profile")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.orange)
                        .padding()
                    Spacer()
                }
                Button {
                    authManager.logout { success in
                        if success {
                            print("Successfully logged out.")
                            isLoggedIn = false
                            
                        } else {
                            print("Error logging out: \(authManager.errorMessage ?? "Unknown error")")
                        }
                    }
                    
                } label: {
                    Text("Sign Out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 130)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                        .shadow(color: .orange.opacity(0.7), radius: 5)
                }
                Spacer()
            }.navigationTitle("")
                .navigationBarHidden(true)
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
