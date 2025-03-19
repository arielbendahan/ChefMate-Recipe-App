import SwiftUI

struct RecipeScrollView: View {
    @State private var recipes: [Recipe] = []
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 50) {
                    ForEach(recipes, id: \.id) { recipe in
                        NavigationLink(destination: RecipeInfoView(recipeId: recipe.id)) {
                            RecipeCard(recipe: recipe)
                        }
                    }
                }
                .padding()
            }
        }
        .buttonStyle(PlainButtonStyle())
        .task {
            do {
                recipes = try await ApiManager.shared.fetchRecipes()
                print("Fetched recipes:", recipes)
            }
            catch
            {
                print("Error fetching recipes: \(error)")
            }
        }
    }
}

struct RecipeScrollView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeScrollView()
    }
}
