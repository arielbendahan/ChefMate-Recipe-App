//
//  EditProfileScreen.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-04-14.
//

import SwiftUI

struct EditProfileScreen: View {
    @ObservedObject var authManager: AuthManager
    @State private var newFirstName = ""
    @State private var newLastName = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var successMessage = ""

    var body: some View {
        Form {
            Section(header: Text("Update Name")) {
                TextField("First Name", text: $newFirstName)
                TextField("Last Name", text: $newLastName)
                Button("Update Name") {
                    updateName()
                }
            }

            Section(header: Text("Change Password")) {
                SecureField("New Password", text: $newPassword)
                SecureField("Confirm Password", text: $confirmPassword)
                Button("Update Password") {
                    updatePassword()
                }
            }

            if !successMessage.isEmpty {
                Section {
                    Text(successMessage)
                        .foregroundColor(successMessage.contains("success") ? .green : .red)
                }
            }
        }
        .navigationTitle("Edit Profile")
        .onAppear {
            newFirstName = authManager.firstName
            newLastName = authManager.lastName
        }
    }

    private func updateName() {
        guard !newFirstName.trimmingCharacters(in: .whitespaces).isEmpty,
              !newLastName.trimmingCharacters(in: .whitespaces).isEmpty else {
            successMessage = "First and Last name cannot be empty."
            return
        }
        
        authManager.updateUserName(firstName: newFirstName, lastName: newLastName) { success in
            successMessage = success ? "Name updated successfully!" : "Failed to update name."
        }
    }

    private func updatePassword() {
        guard newPassword == confirmPassword, !newPassword.isEmpty else {
            successMessage = "Passwords do not match or are empty."
            return
        }

        authManager.updateUserPassword(to: newPassword) { success in
            successMessage = success ? "Password updated successfully!" : "Password update failed."
        }
    }
}

struct EditProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileScreen(authManager: AuthManager())
    }
}
