//
//  HomeView.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-03-06.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var recipesViewModel = HomeViewRecipesModel()
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
                    
                    // Featured Recipes
                    HStack {
                        Text("Featured Recipes")
                            .font(.title2)
                            .bold()
                            .padding(.leading)
                            .padding(.top)
                        Spacer()
                    }
                    RecipeScrollView(recipes: recipesViewModel.featuredRecipes)
                        .frame(minHeight: 200)
                    
                    Divider()
                        .frame(width: 300)
                        .padding()
                    
                    // Trending Recipes
                    HStack {
                        Text("Trending Recipes")
                            .font(.title2)
                            .bold()
                            .padding(.leading)
                        Spacer()
                    }
//                    RecipeScrollView(recipes: recipesViewModel.trendingRecipes)
//                        .frame(minHeight: 200)
                    Divider()
                        .frame(width: 300)
                        .padding()
                    
                    // New Recipes
                    HStack {
                        Text("New Recipes")
                            .font(.title2)
                            .bold()
                            .padding(.leading)
                        Spacer()
                    }
//                    RecipeScrollView(recipes: recipesViewModel.newRecipes)
//                        .frame(minHeight: 200)
                    
                    Spacer()
                }
            }.ignoresSafeArea()
            .task {
                if recipesViewModel.featuredRecipes.isEmpty {
                    await recipesViewModel.loadAllRecipes()
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
