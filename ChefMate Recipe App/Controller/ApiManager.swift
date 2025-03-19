//  ApiManager.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-03-09.
//
 
import Foundation
 
class ApiManager {
    static let shared = ApiManager()
    //private let apiKey = "7042b5e9c0ae40258bbb050bf01a6000"
    // Below is backup API Key incase we run out of calls
    private let apiKey = "2472e0b98f1e476a813d92f8a13c4d76"
    private let baseURL = "https://api.spoonacular.com/"
 
    private init() {}
    
    func fetchRecipesIds() async throws -> [Int] {
        let endpoint = "/recipes/complexSearch"
        let urlString = "\(baseURL)\(endpoint)?number=10&instructionsRequired=true&apiKey=\(apiKey)"
 
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
 
        let (data, response) = try await URLSession.shared.data(from: url)
 
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
 
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        let idList = json?["results"] as? [[String: Any]] ?? []
        return idList.compactMap { $0["id"] as? Int }
    }
    
    func fetchRecipeDetails(for id: Int) async throws -> Recipe {
        let urlString = "\(baseURL)/recipes/\(id)/information?apiKey=\(apiKey)"
 
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
 
        let (data, response) = try await URLSession.shared.data(from: url)
 
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
 
        return try JSONDecoder().decode(Recipe.self, from: data)
    }
 
    // Fetch 10 recipes, no query
    func fetchRecipes() async throws -> [Recipe] {
        let ids = try await fetchRecipesIds()
        var recipes: [Recipe] = []
        
        for id in ids{
            let recipe = try await fetchRecipeDetails(for: id)
            recipes.append(recipe)
        }
        
        return recipes
    }
 
    // query, first 10 results, with filters
    func searchRecipes(query: String, filters: Set<Filter>) async throws -> [Recipe] {
        let endpoint = "/recipes/complexSearch"
        let urlString = "\(baseURL)\(endpoint)?query=\(query)&number=10&apiKey=\(apiKey)"

        //apply filters if exists
        if !filters.isEmpty {
            cuisineList: [String] = []
            dietList: [String] = []
            ingredientList: [String] = []

            for filter in filters {
                switch filter.type {
                case .cuisine:
                    cuisineList.append(filter.name)
                case .diet:
                    dietList.append(filter.name)
                case .ingredient:
                    ingredientList.append(filter.name)
                }
            }

            if !cuisineList.isEmpty {
                urlString += "&cuisine=\(cuisineList.joined(separator: ","))"
            }
            if !dietList.isEmpty {
                urlString += "&diet=\(dietList.joined(separator: ","))"
            }
            if !ingredientList.isEmpty {
                urlString += "&includeIngredients=\(ingredientList.joined(separator: ","))"
            }
        }
 
        //Ensure the url is valid. In spoonacular, query and filters can include spaces, so we need to encode the url
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            throw APIError.invalidURL
        }
 
        let (data, response) = try await URLSession.shared.data(from: url)
 
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
 
        let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
        return decodedResponse.results
    }
    
}
 
struct RecipeResponse: Codable {
    let results: [Recipe]
}
 
// Define custom errors
enum APIError: Error {
    case invalidURL
    case invalidResponse
}
