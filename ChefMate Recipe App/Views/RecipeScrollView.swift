import SwiftUI

struct RecipeScrollView: View {
    @State private var recipes: [RecipeCardModel] = []
    
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
                let fetchedRecipes = try await ApiManager.shared.fetchRecipes()
                recipes = fetchedRecipes.map { recipe in
                    RecipeCardModel(id: recipe.id, title: recipe.title, image: recipe.image, readyInMinutes: recipe.readyInMinutes, spoonacularScore: recipe.spoonacularScore)
                }
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
