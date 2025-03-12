//
//  RecipeScrollView.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-03-12.
//

import SwiftUI

struct RecipeScrollView: View {
    @State private var recipes: [Recipe] = []
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 50) {
                ForEach(recipes, id: \..id) { recipe in
                    RecipeCard(recipe: recipe)
                }
            }
            .padding()
        }
        .task {
            do {
                recipes = try await ApiManager.shared.fetchRecipes()
            } catch {
                print("Error fetching recipes: \(error)")
            }
        }
    }
}

struct RecipeScrollView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeScrollView()
    }
}
