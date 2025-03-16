import SwiftUI

struct RecipeInfoView: View {
    let recipeId: Int
    @State private var recipeDetail: Recipe? = nil
    
    var body: some View {
        ScrollView {
            if let recipe = recipeDetail {
                VStack(alignment: .leading, spacing: 10) {
                    // Recipe Image
                    AsyncImage(url: URL(string: recipe.image)) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 250)
                    .cornerRadius(10)
                    
                    // Recipe Title
                    Text(recipe.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // Time Info
                    HStack {
                        Text("Prep: \(recipe.preparationMinutes) min")
                        Text("Cook: \(recipe.cookingMinutes) min")
                        Text("Total: \(recipe.readyInMinutes) min")
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    
                    // Short Description
                    Text(recipe.summary)
                        .font(.body)
                        .padding(.vertical)
                    
                    // Ingredients
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ForEach(recipe.extendedIngredients, id: \.name) { ingredient in
                        Text("• \(ingredient.amount) \(ingredient.unit) \(ingredient.name)")
                    }
                    
                    // Instructions
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ForEach(recipe.instructions.indices, id: \.self) { index in
                        Text("\(index + 1). \(recipe.instructions[index])")
                            .padding(.vertical, 2)
                    }
                }
                .padding()
            } else {
                ProgressView("Loading Recipe...")
                    .onAppear { fetchRecipeDetails() }
            }
        }
        .navigationTitle("Recipe Details")
    }
    func fetchRecipeDetails() {
        Task {
            do {
                let details = try await ApiManager.shared.fetchRecipeDetails(for: recipeId)
                self.recipeDetail = details // Update the state on the main thread
            } catch {
                print("Error fetching details: \(error.localizedDescription)")
            }
        }
    }
}

struct RecipeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInfoView(recipeId: 716429)
    }
}
