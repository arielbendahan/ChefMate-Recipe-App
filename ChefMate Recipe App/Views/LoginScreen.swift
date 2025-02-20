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
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            
            Text("Log in")
                .font(.largeTitle)
                .foregroundStyle(.orange)
                .autocapitalization(.none)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(){
                //validate
                submitLogin()
                //submit method
            } label: {
                Text("Submit")
                    .frame(width: 100, height: 50)
                    .background(.orange)
                    .clipShape(Capsule())
                    .foregroundStyle(.white)
                    
            }.padding()
            

            
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(errorMsg), dismissButton: .default(Text("ok")))
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
        
        authManager.login(user: user)
        
        if authManager.user != nil {
            //go to homescreen
        } else {
            //error
            showAlert = true
            errorMsg = authManager.errorMessage ?? ""
        }
        
        //go to homescreen
        
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
