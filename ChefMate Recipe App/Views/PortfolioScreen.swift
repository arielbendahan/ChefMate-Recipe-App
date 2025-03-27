//
//  PortfolioScreen.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-03-26.
//

import SwiftUI

struct PortfolioScreen: View {
    var body: some View {
        VStack {
            HStack {
                Text("My Cookbook")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.orange)
                    .padding()
                Spacer()
            }
            Spacer()
        }
    }
}

struct PortfolioScreen_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioScreen()
    }
}
