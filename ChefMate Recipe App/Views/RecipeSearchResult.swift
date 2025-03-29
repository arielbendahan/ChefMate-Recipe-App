//
//  RecipeSearchResult.swift
//  ChefMate Recipe App
//
//  Created by user939647 on 3/29/25.
//

import SwiftUI

struct RecipeSearchResult: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Color.white
                
                AsyncImage(url: URL(string: recipe.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 180, height: 160)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 160)
                            .clipped()
                    case .failure:
                        Color.gray
                            .frame(width: 180, height: 160)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .frame(height: 160)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(recipe.title)
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(height: 50, alignment: .topLeading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                
                HStack {
                    Label("\(recipe.readyInMinutes) min", systemImage: "clock")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Label("\(Int(recipe.spoonacularScore.rounded()))", systemImage: "star.fill")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                }
            }
            .padding()
            .frame(height: 80)
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .frame(width: 360)
    }
}

#Preview {
    RecipeSearchResult(recipe: Recipe(
        id: 12345,
        title: "Spaghetti Carbonara",
        image: "https://img.spoonacular.com/recipes/12345-312x231.jpg",
        readyInMinutes: 25,
        preparationMinutes: 10,
        cookingMinutes: 15,
        extendedIngredients: [],
        analyzedInstructions: [],
        summary: "A classic Italian pasta dish with eggs, cheese, pancetta, and pepper.",
        spoonacularScore: 87.5
    ))
}
