//
//  ApiManager.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-03-09.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()
    private let apiKey = "replace_with_api_key"
    private let baseURL = "https://api.spoonacular.com/"

    private init() {}

    // Fetch 10 recipes, no query
    func fetchRecipes() async throws -> [Recipe] {
        let endpoint = "/recipes/complexSearch"
        let urlString = "\(baseURL)\(endpoint)?number=10&apiKey=\(apiKey)"

        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }

        let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
        return decodedResponse.results
    }

    // Only query, first 10 results, no filters
    func searchRecipes(query: String) async throws -> [Recipe] {
        let endpoint = "/recipes/complexSearch"
        let urlString = "\(baseURL)\(endpoint)?query=\(query)&number=10&apiKey=\(apiKey)"

        guard let url = URL(string: urlString) else {
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
