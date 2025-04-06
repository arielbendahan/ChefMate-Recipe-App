//
//  HomeViewRecipesModel.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-04-06.
//

import Foundation

class HomeViewRecipesModel: ObservableObject {
    @Published var featuredRecipes: [Recipe] = []
    @Published var trendingRecipes: [Recipe] = []
    @Published var newRecipes: [Recipe] = []
    
    func loadAllRecipes() async {
        do {
            featuredRecipes = try await ApiManager.shared.fetchRandomRecipes()
            trendingRecipes = try await ApiManager.shared.fetchRandomRecipes()
            newRecipes = try await ApiManager.shared.fetchRandomRecipes()
        } catch {
            print("Error fetching recipes: \(error)")
        }
    }
}
