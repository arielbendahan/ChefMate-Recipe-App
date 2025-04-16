//
//  PortfolioScreen.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-03-26.
//

import SwiftUI

struct PortfolioScreen: View {
    @State private var favoriteRecipes: [Recipe] = []
    @State private var isLoading = true
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 125)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 3)
                
                HStack {
                    Text("My Cookbook")
                        .font(.title)
                        .bold()
                        .foregroundColor(.orange)
                        .padding(.leading)
                        .padding(.top, 50)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            
            if isLoading {
                ProgressView()
                Spacer()
            } else if favoriteRecipes.isEmpty {
                Text("You have no favourited recipes")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(favoriteRecipes, id: \.id) { recipe in
                            NavigationLink(destination: RecipeInfoView(recipeId: recipe.id)) {
                                PortfolioCard(recipe: RecipeCardModel(
                                    id: recipe.id,
                                    title: recipe.title,
                                    image: recipe.image,
                                    readyInMinutes: recipe.readyInMinutes,
                                    spoonacularScore: recipe.spoonacularScore
                                ))
                            }
                        }
                    }
                    .padding()
                }.padding(.bottom, 25)
            }
        }.ignoresSafeArea(edges: .top)
        .onAppear {
            loadFavoriteRecipes()
        }
    }
    private func loadFavoriteRecipes() {
        AuthManager().fetchFavoriteRecipes { favoriteIds in
            guard let favoriteIds = favoriteIds, !favoriteIds.isEmpty else {
                isLoading = false
                return
            }
            
            Task {
                do {
                    let recipes = try await withThrowingTaskGroup(of: (Int, Recipe).self) { group -> [Int: Recipe] in
                        for id in favoriteIds {
                            group.addTask {
                                let recipe = try await ApiManager.shared.fetchRecipeDetails(for: id)
                                return (id, recipe)
                            }
                        }
                        
                        var results: [Int: Recipe] = [:]
                        for try await (id, recipe) in group {
                            results[id] = recipe
                        }
                        return results
                    }

                    let orderedRecipes = favoriteIds.compactMap { id in
                        return recipes[id] }

                    DispatchQueue.main.async {
                        self.favoriteRecipes = orderedRecipes
                        self.isLoading = false
                    }

                } catch {
                    print("Error loading favorite recipes: \(error)")
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            }
        }
    }
}

struct PortfolioScreen_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioScreen()
    }
}
