//
//  Recipe Card Model.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-03-16.
//

import Foundation

struct RecipeCardModel: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String
    let readyInMinutes: Int
    let spoonacularScore: Double
}
