//
//  PortfolioCard.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-03-30.
//

import SwiftUI

struct PortfolioCard: View {
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
                        ZStack {
                            Color.gray
                            Text("No Image")
                                .foregroundColor(.white)
                                .bold()
                        }.frame(width: 200, height: 160)
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
        .frame(width: 200)
    }
}

struct PortfolioCard_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioCard(recipe: RecipeCardModel(id: 12345, title: "Pasta", image: "https://img.spoonacular.com/recipes/12345-312x231.jpg", readyInMinutes: 10, spoonacularScore: 86))
    }
}
