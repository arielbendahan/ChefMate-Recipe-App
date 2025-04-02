//
//  RegisterScreen.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-03-06.
//

import SwiftUI

struct RegisterScreen: View {
    @StateObject private var authManager = AuthManager()
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var showAlert = false
    @State private var errorMsg = ""
    @State private var isRegistered = false
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some View {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                
                Text("Register")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(10)
                    .background(Color.white)
                    .padding()
                    .shadow(color: .gray.opacity(0.3), radius: 5)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(10)
                    .background(Color.white)
                    .padding()
                    .shadow(color: .gray.opacity(0.3), radius: 5)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(10)
                    .background(Color.white)
                    .padding()
                    .shadow(color: .gray.opacity(0.3), radius: 5)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(10)
                    .background(Color.white)
                    .padding()
                    .shadow(color: .gray.opacity(0.3), radius: 5)
                
                Button() {
                    submitRegister()
                } label: {
                    Text("Register")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 130)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                        .shadow(color: .orange.opacity(0.7), radius: 5)
                }
                .padding()
                
                NavigationLink(destination: HomeScreen(), isActive: $isRegistered) {
                    EmptyView()
                }
                
                Spacer()
                
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMsg), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private func submitRegister() {
        if email.isEmpty || password.isEmpty {
            showAlert = true
            errorMsg = "Missing Credentials"
            return
        }
        
        let user = UserModel(id: "",email: email, firstName: firstName, lastName: lastName ,password: password)
        authManager.register(user: user) { success in
                if success {
                    isLoggedIn = true
                    isRegistered = true
                } else {
                    showAlert = true
                    errorMsg = authManager.errorMessage ?? "Registration failed"
            }
        }
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
