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
            HomeView()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle")
                }
            HomeView()
                .tabItem {
                    Image(systemName: "book.fill")
                }
            HomeView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                }
        }.accentColor(.orange)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
