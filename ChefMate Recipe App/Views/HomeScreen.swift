//
//  HomeScreen.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-02-19.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        TabView() {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            ExploreScreen()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle")
                }
            PortfolioScreen()
                .tabItem {
                    Image(systemName: "book.fill")
                }
            ProfileScreen()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                }
        }.accentColor(.orange)
            .navigationBarBackButtonHidden(true)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
