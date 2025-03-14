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
    let spoonacularScore: Double
}
