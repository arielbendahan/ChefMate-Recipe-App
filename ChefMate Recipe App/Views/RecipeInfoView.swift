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
                        
                        if let prepMinutes = recipe.preparationMinutes {
                            Text("Prep: \(prepMinutes) min")
                        }
                        
                        if let cookMinutes = recipe.cookingMinutes {
                            Text("Cook: \(cookMinutes) min")
                        }
                        Text("Total: \(recipe.readyInMinutes) min")
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    
                    // Short Description
                    Text(recipe.summary.stripHTML)
                        .font(.body)
                        .padding(.vertical)
                    
                    // Ingredients
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ForEach(recipe.extendedIngredients, id: \.name) { ingredient in
                        let fraction = fractionize(ingredient.amount)
                        Text("• \(fraction) \(ingredient.unit) \(ingredient.name)")
                    }
                    
                    // Instructions
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    if let instructions = recipeDetail?.analyzedInstructions {
                        ForEach(instructions, id: \.name) { instruction in
                            ForEach(instruction.steps, id: \.number) { step in
                                Text("**\(step.number).** \(step.step)")
                            }
                        }
                    }
                }
                .padding()
            } else {
                ProgressView("Loading Recipe...")
                    .onAppear { fetchRecipeDetails() }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    func fetchRecipeDetails() {
        Task {
            do {
                let details = try await ApiManager.shared.fetchRecipeDetails(for: recipeId)
                self.recipeDetail = details
            } catch {
                print("Error fetching details: \(error.localizedDescription)")
            }
        }
    }
    // Converts decimal amount from API into a fraction for a nicer look
    func fractionize(_ value: Double) -> String {
        let wholeNumber = Int(value)
        let decimalPart = value - Double(wholeNumber)
        
        let commonFractions: [(Double, String)] = [
            (0.125, "⅛"), (0.25, "¼"), (0.333, "⅓"), (0.5, "½"),
            (0.666, "⅔"), (0.75, "¾"), (1.0, "1")
        ]
        
        for (decimal, fraction) in commonFractions {
            if abs(decimalPart - decimal) < 0.02 {
                if wholeNumber > 0 {
                    return "\(wholeNumber) \(fraction)"
                } else {
                    return fraction
                }
            }
        }
        
        return wholeNumber > 0 ? "\(wholeNumber)" : String(format: "%.2f", value)
    }
}

struct RecipeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInfoView(recipeId: 715415)
    }
}
