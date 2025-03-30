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
            .ignoresSafeArea()
            
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
                }
            }
        }
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
                    let recipes = try await withThrowingTaskGroup(of: Recipe.self) { group -> [Recipe] in
                        for id in favoriteIds {
                            group.addTask {
                                try await ApiManager.shared.fetchRecipeDetails(for: id)
                            }
                        }
                        
                        var recipes = [Recipe]()
                        for try await recipe in group {
                            recipes.append(recipe)
                        }
                        return recipes
                    }
                    
                    DispatchQueue.main.async {
                        self.favoriteRecipes = recipes
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
