//
//  RecipeCard.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-03-12.
//

import SwiftUI


struct RecipeCard: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Color.white // Ensures full background coverage
                
                AsyncImage(url: URL(string: recipe.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 200, height: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 160)
                            .clipped()
                    case .failure:
                        Color.gray
                            .frame(width: 200, height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .frame(height: 160) // Ensures image always has space
            
            VStack(alignment: .leading, spacing: 8) {
                Text(recipe.title)
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(height: 70) // Allows space for varying title lengths
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .frame(height: 70) // Adds more space to prevent pushing content upwards
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .frame(width: 200)
    }
}



struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCard(recipe: Recipe(
            id: 12345,
            title: "Spaghetti Carbonara",
            image: "https://img.spoonacular.com/recipes/12345-312x231.jpg"
        ))
    }
}

