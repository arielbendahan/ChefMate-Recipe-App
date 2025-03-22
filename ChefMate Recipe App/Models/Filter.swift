//
//  Filter.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-03-13.
//

import Foundation

/*
 struct Filter: Identifiable, Hashable {
 enum FilterType {
 case cuisine
 case diet
 case ingredient
 }
 
 
 var id: UUID
 var name: String
 let type: FilterType
 
 init(name: String, type: FilterType) {
 self.name = name
 self.type = type
 self.id = UUID()
 }
 
 
 //For it to conform Equatable
 static func == (lhs: Filter, rhs: Filter) -> Bool {
 return lhs.name == rhs.name
 }
 
 func hash(into hasher: inout Hasher) {
 hasher.combine(name)
 }
 }
 */

class Filter: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let type: FilterType
    
    init(name: String, type: FilterType) {
        self.name = name
        self.type = type
    }
    
    func apply(to builder: RecipeSearchBuilder) {
        switch type {
        case .cuisine:
            builder.addCuisine(name)
        case .diet:
            builder.addDiet(name)
        case .ingredient:
            builder.addIngredient(name)
        case .mealType:
            builder.addMealType(name)
        }
    }
    
    //So it conforms to Equatable, needed to use a hashset
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(type)
    }

    static func == (lhs: Filter, rhs: Filter) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type
    }
}

enum FilterType {
    case cuisine, diet, ingredient, mealType
}
