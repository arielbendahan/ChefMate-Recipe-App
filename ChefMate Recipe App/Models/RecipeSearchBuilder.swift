//
//  RecipeSearchBuilder.swift
//  ChefMate Recipe App
//
//  Created by user939647 on 3/22/25.
//

import Foundation

class RecipeSearchBuilder {
    private var query: String = ""
    private var cuisineList: [String] = []
    private var dietList: [String] = []
    private var mealTypeList: [String] = []
    private var intoleranceList: [String] = []

    init(query: String) {
        self.query = query
    }

    func addCuisine(_ cuisine: String) {
        cuisineList.append(cuisine)
    }

    func addDiet(_ diet: String) {
        dietList.append(diet)
    }

    func addMealType(_ mealType: String) {
        mealTypeList.append(mealType)
    }

    func addIntolerance(_ intolerance: String) {
        intoleranceList.append(intolerance)
    }

    func build() -> String {
        var urlString = "&query=\(query)"

        if !cuisineList.isEmpty {
            urlString += "&cuisine=\(cuisineList.joined(separator: ","))"
        }

        if !dietList.isEmpty {
            urlString += "&diet=\(dietList.joined(separator: ","))"
        }

        if !mealTypeList.isEmpty {
            urlString += "&type=\(mealTypeList.joined(separator: ","))"
        }

        if !intoleranceList.isEmpty {
            urlString += "&intolerances=\(intoleranceList.joined(separator: ","))"
        }
        
        return urlString
    }
}
