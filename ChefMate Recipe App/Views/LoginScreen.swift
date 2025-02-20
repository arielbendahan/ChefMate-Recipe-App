//
//  LoginScreen.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-02-19.
//

import SwiftUI

struct LoginScreen: View {
    @StateObject private var authManager = AuthManager()
    @State private var email = ""
    @State private var password = ""
    //@State private var isValidated = false
    @State private var showAlert = false
    @State private var errorMsg = ""
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)

                Text("Log In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)

                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(10)
                    .background(Color.white)
                    .padding(.horizontal)
                    .shadow(color: .gray.opacity(0.3), radius: 5)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(10)
                    .background(Color.white)
                    .padding()
                    .shadow(color: .gray.opacity(0.3), radius: 5)
                
                
                
                HStack(alignment: .center, spacing: 20) {
                    Button(){
                        //validate
                        submitLogin()
                        //submit method
                    } label: {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 125)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(10)
                            .shadow(color: .orange.opacity(0.7), radius: 5)
                        
                    }.padding()
                    VStack(alignment: .leading, spacing: 5) {

                        Button() {
                            // navigation link to register page
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
                        Text("Don't have an account?")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                    }.frame(maxHeight: 50)
                        .padding(.top, 21)
                }
                
                
                NavigationLink(destination: HomeScreen(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
                Spacer()

                
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMsg), dismissButton: .default(Text("ok")))
                
            }
        }
    }
    
    
    private func submitLogin(){
        //validate input
        if email == "" || password == "" {
            showAlert = true
            errorMsg = "Missing Credentials"
            return
        }
        
        
        let user = UserModel(email: email, password: password)
        
        authManager.login(user: user) { success in
            if success {
                isLoggedIn = true
            }
            else {
                showAlert = true
                errorMsg = authManager.errorMessage ?? "Login failed"
            }
        }
        
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
