//
//  Recipe.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-03-09.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String
    let readyInMinutes: Int
    let preparationMinutes: Int?
    let cookingMinutes: Int?
    let extendedIngredients: [Ingredient]
    let instructions: String
    let summary: String
    let spoonacularScore: Double
    
}
