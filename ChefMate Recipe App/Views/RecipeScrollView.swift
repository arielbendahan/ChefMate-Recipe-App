import SwiftUI

struct RecipeScrollView: View {
    let recipes: [Recipe]

    var body: some View {
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
        .buttonStyle(PlainButtonStyle())
    }
}


struct RecipeScrollView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeScrollView(recipes: [])
    }
}
