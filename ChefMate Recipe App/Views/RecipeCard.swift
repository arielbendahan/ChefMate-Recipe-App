//
//  RecipeCard.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-03-12.
//

import SwiftUI

struct RecipeCard: View {
    let recipe: RecipeCardModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Color.white
                
                AsyncImage(url: URL(string: recipe.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 200, height: 160)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 160)
                            .clipped()
                    case .failure:
                        Color.gray
                            .frame(width: 200, height: 160)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .frame(height: 160)
            //.cornerRadius(15, corners: [.topLeft, .topRight]) // Rounded top corners
            
            VStack(alignment: .leading, spacing: 8) {
                Text(recipe.title)
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(height: 50, alignment: .topLeading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                HStack {
                    Label("\(recipe.readyInMinutes) min", systemImage: "clock")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Label("\(Int(recipe.spoonacularScore.rounded()))", systemImage: "star.fill")
                        .font(.subheadline)
                        .foregroundColor(.orange) // Improved visibility
                }
            }
            .padding()
            .frame(height: 80)
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .frame(width: 200)
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCard(recipe: RecipeCardModel(
            id: 12345,
            title: "Spaghetti Carbonara",
            image: "https://img.spoonacular.com/recipes/12345-312x231.jpg",
            readyInMinutes: 20,
            spoonacularScore: 84.3
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
