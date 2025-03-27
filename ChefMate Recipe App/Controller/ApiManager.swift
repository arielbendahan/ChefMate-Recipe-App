//  ApiManager.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-03-09.
//
 
import Foundation
 
class ApiManager {
    static let shared = ApiManager()
    // Two Spoonacular API keys because 150 calls is drained like water
    // API Key 1
    //private let apiKey = "7042b5e9c0ae40258bbb050bf01a6000"
    // API Key 2
    //private let apiKey = "2472e0b98f1e476a813d92f8a13c4d76"
    // API Key 3
    private let apiKey = "4e39f855e5be484d9b42ff63ab8bfa8a"
    private let baseURL = "https://api.spoonacular.com/"
 
    private init() {}

    
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
        let endpoint = "/recipes/complexSearch"
        let urlString = "\(baseURL)\(endpoint)?number=10&addRecipeInformation=true&apiKey=\(apiKey)"
 
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
 
        let (data, response) = try await URLSession.shared.data(from: url)
 
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
 
        return try JSONDecoder().decode(RecipeResponse.self, from: data)
    }
 
    // query, first 10 results, with filters
    func searchRecipe(query: String, filters: Set<Filter>) async throws -> [RecipeSearchResult] {
        let endpoint = "/recipes/complexSearch"
        var urlString = "\(baseURL)\(endpoint)?number=10&instructionsRequired=true&addRecipeInformation=true&apiKey=\(apiKey)"

        let builder = RecipeSearchBuilder(query: query)

        for filter in filters {
            filter.apply(to: builder)
        }

        urlString += builder.build()

        //Ensure the url is valid. In spoonacular, query and filters can include spaces, so we need to encode the url
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            throw APIError.invalidURL
        }
     
        let (data, response) = try await URLSession.shared.data(from: url)
     
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print(urlString)
            throw APIError.invalidResponse
        }
     
        let decodedResponse = try JSONDecoder().decode(RecipeSearchResultResponse.self, from: data)
        return decodedResponse.results
    }
    
    // Fetch 10 random recipes (different that the search recipe function with no query as this is always random each call)
    func fetchRandomRecipes() async throws -> [Recipe] {
        let endpoint = "/recipes/random"
        let urlString = "\(baseURL)\(endpoint)?number=10&instructionsRequired=true&addRecipeInformation=true&apiKey=\(apiKey)"

        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }

        let decodedResponse = try JSONDecoder().decode(RecipeRandomResponse.self, from: data)
        return decodedResponse.recipes
    }

    
    
    
}

struct RecipeSearchResultResponse: Codable {
    let results: [RecipeSearchResult]
}


struct RecipeResponse: Codable {
    let results: [Recipe]
}

struct RecipeRandomResponse: Codable {
    let recipes: [Recipe]
}
 
// Define custom errors
enum APIError: Error {
    case invalidURL
    case invalidResponse
}
