//
//  SplashScreen.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-02-19.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @StateObject var authManager = AuthManager()
    var body: some View {
        if isActive {
            LoginScreen()
        }
        else {
            ZStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
