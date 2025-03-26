//
//  HomeView.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-03-06.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
            ScrollView {
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 125)
                            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 3)
                            
                        
                        HStack {
                            Text("ChefMate")
                                .font(.title)
                                .bold()
                                .foregroundColor(.orange)
                                .padding(.leading)
                                .padding(.top, 50)
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Featured Recipes Title
                    HStack {
                        Text("Featured Recipes")
                            .font(.title2)
                            .bold()
                            .padding(.leading)
                            .padding(.top)
                        Spacer()
                    }
                    RecipeScrollView()
                        .frame(minHeight: 200)
                    
                    Divider()
                        .frame(width: 300)
                        .padding()
                    
                    // Trending Recipes Title
                    HStack {
                        Text("Trending Recipes")
                            .font(.title2)
                            .bold()
                            .padding(.leading)
                        Spacer()
                    }
                    // RecipeScrollView()
                    Divider()
                        .frame(width: 300)
                        .padding()
                    
                    // Favourited Recipes Title
                    HStack {
                        Text("Favourited Recipes")
                            .font(.title2)
                            .bold()
                            .padding(.leading)
                        Spacer()
                    }
                    // RecipeScrollView()
                    
                    Spacer()
                }
            }.ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
