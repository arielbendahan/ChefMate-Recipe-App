import SwiftUI

struct RecipeInfoView: View {
    let recipeId: Int
    @State private var recipeDetail: Recipe? = nil
    @State private var isFavorite = false
    @State private var checkedSteps: Set<Int> = []
    
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
                    HStack {
                        Text(recipe.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        Button {
                            if isFavorite {
                                AuthManager().removeRecipeFromFavorites(recipeId: recipeId) { success in
                                    if success {
                                        isFavorite = false
                                    }
                                }
                            } else {
                                AuthManager().addRecipeToFavorites(recipeId: recipeId) { success in
                                    if success {
                                        isFavorite = true
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                                .font(.system(size: 35))
                                .foregroundColor(.yellow)
                        }
                    }
                    
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
                    
                    if let totalSteps = recipeDetail?.analyzedInstructions.first?.steps.count, totalSteps > 0, !checkedSteps.isEmpty {
                        let isCompleted = checkedSteps.count == totalSteps
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(isCompleted ? "Recipe Completed! 🎉" : "Completed Steps: \(checkedSteps.count)/\(totalSteps)")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(.top, 20)

                            ProgressView(value: Double(checkedSteps.count), total: Double(totalSteps))
                                .progressViewStyle(LinearProgressViewStyle(tint: isCompleted ? .green : .orange))
                                .frame(height: 8)
                                .clipShape(Capsule())
                        }
                        .padding(.bottom, 5)
                    }

                    
                    // Instructions
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    if let instructions = recipeDetail?.analyzedInstructions {
                        ForEach(instructions, id: \.name) { instruction in
                            ForEach(instruction.steps, id: \.number) { step in
                                HStack {
                                    Button(action: {
                                        if checkedSteps.contains(step.number) {
                                            checkedSteps.remove(step.number)
                                        } else {
                                            checkedSteps.insert(step.number)
                                        }
                                    }) {
                                        Image(systemName: checkedSteps.contains(step.number) ? "checkmark.square.fill" : "square")
                                            .foregroundColor(.blue)
                                    }
                                    Text("**\(step.number).** \(step.step)")
                                        .strikethrough(checkedSteps.contains(step.number))
                                        .foregroundColor(checkedSteps.contains(step.number) ? .gray : .primary)
                                        .animation(.easeInOut, value: checkedSteps)
                                }
                            }
                        }
                    }
                }
                .padding()
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                ProgressView("Loading Recipe...")
                    .onAppear { fetchRecipeDetails() }
            }
        }.onAppear {
            AuthManager().fetchFavoriteRecipes { favorites in
                if let favorites = favorites {
                    isFavorite = favorites.contains(recipeId)
                }
            }
        }
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
