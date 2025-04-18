//
//  ExploreScreen.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-03-12.
//
 
import SwiftUI
 
struct ExploreScreen: View {
    @State var searchText = ""
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    
    var cuisineFilters: [Filter] = [
            .init(name: "African", type: .cuisine),
            .init(name: "Asian", type: .cuisine),
            .init(name: "American", type: .cuisine),
            .init(name: "British", type: .cuisine),
            .init(name: "Cajun", type: .cuisine),
            .init(name: "Caribbean", type: .cuisine),
            .init(name: "Chinese", type: .cuisine),
            .init(name: "Eastern European", type: .cuisine),
            .init(name: "European", type: .cuisine),
            .init(name: "French", type: .cuisine),
            .init(name: "German", type: .cuisine),
            .init(name: "Greek", type: .cuisine),
            .init(name: "Indian", type: .cuisine),
            .init(name: "Irish", type: .cuisine),
            .init(name: "Italian", type: .cuisine),
            .init(name: "Japanese", type: .cuisine),
            .init(name: "Jewish", type: .cuisine),
            .init(name: "Korean", type: .cuisine),
            .init(name: "Latin American", type: .cuisine),
            .init(name: "Mediterranean", type: .cuisine),
            .init(name: "Mexican", type: .cuisine),
            .init(name: "Middle Eastern", type: .cuisine),
            .init(name: "Nordic", type: .cuisine),
            .init(name: "Southern", type: .cuisine),
            .init(name: "Spanish", type: .cuisine),
            .init(name: "Thai", type: .cuisine),
            .init(name: "Vietnamese", type: .cuisine),
        ]
        
    var dietFilters: [Filter] = [
        .init(name: "Gluten Free", type: .diet),
        .init(name: "Ketogenic", type: .diet),
        .init(name: "Vegetarian", type: .diet),
        .init(name: "Lacto-Vegetarian", type: .diet),
        .init(name: "Ovo-Vegetarian", type: .diet),
        .init(name: "Vegan", type: .diet),
        .init(name: "Pescetarian", type: .diet),
        .init(name: "Paleo", type: .diet),
        .init(name: "Primal", type: .diet),
        .init(name: "Low FODMAP", type: .diet),
        .init(name: "Whole30", type: .diet),
    ]

    var mealTypeFilters: [Filter] = [
        .init(name: "main course", type: .mealType),
        .init(name: "bread", type: .mealType),
        .init(name: "side dish", type: .mealType),
        .init(name: "dessert", type: .mealType),
        .init(name: "appetizer", type: .mealType),
        .init(name: "salad", type: .mealType),
        .init(name: "breakfast", type: .mealType),
        .init(name: "soup", type: .mealType),
        .init(name: "beverage", type: .mealType),
        .init(name: "sauce", type: .mealType),
        .init(name: "marinade", type: .mealType),
        .init(name: "fingerfood", type: .mealType),
        .init(name: "snack", type: .mealType),
        .init(name: "drink", type: .mealType),
    ]
    
    var intoleranceFilters: [Filter] = [

        .init(name: "dairy", type: .intolerance),
        .init(name: "egg", type: .intolerance),
        .init(name: "gluten", type: .intolerance),
        .init(name: "grain", type: .intolerance),
        .init(name: "peanut", type: .intolerance),
        .init(name: "seafood", type: .intolerance),
        .init(name: "sesame", type: .intolerance),
        .init(name: "shellfish", type: .intolerance),
        .init(name: "soy", type: .intolerance),
        .init(name: "sulfite", type: .intolerance),
        .init(name: "tree nut", type: .intolerance),
        .init(name: "Wheat", type: .intolerance),
    ]
    
    //state booleans for the collapsable views
    @State private var isCuisineExpanded: Bool = false
    @State private var isDietExpanded: Bool = false
    @State private var isMealTypeExpanded: Bool = false
    @State private var isIntolerancesExpanded: Bool = false
    
    
    @State private var selectedFilters: Set<Filter> = []
    
    @State private var searchResultRecipe: [Recipe] = []
    
    var body: some View {
        VStack (alignment: .leading){
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 125)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 3)
                
                HStack {
                    Text("Explore")
                        .font(.title)
                        .bold()
                        .foregroundColor(.orange)
                        .padding(.leading)
                        .padding(.top, 50)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            
            HStack(spacing: 10){
                
                TextField("Search recipe...", text: $searchText)
                    .padding(7)
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(radius: 8, y: 5)
                
                Button {
                    Task {
                        await getSearchResults()
                    }
                } label: {
                    Image(systemName: "magnifyingglass.circle")
                        .font(.title)
                        .foregroundStyle(.orange)
                }
            }.padding()
            
            Text("Filters")
                .font(.title2)
                .bold()
                .padding(.horizontal)
            
            //cuisine filters
            VStack(alignment: .leading, spacing: 10){
                Button {
                    withAnimation {
                        isCuisineExpanded.toggle()
                    }
                } label: {
                    HStack {
                        Text("By Cuisine")
                            .font(.title3)
                        
                        Spacer()
                        
                        Image(systemName: isCuisineExpanded ? "chevron.up" : "chevron.down")
                    }
                }.buttonStyle(PlainButtonStyle())
                
                if isCuisineExpanded{
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, spacing: 5){
                            ForEach(cuisineFilters) {
                                filter in
                                Button {
                                    toggleFilter(filter)
                                    
                                } label: {
                                    Text(filter.name)
                                        .padding(.horizontal)
                                        .background(selectedFilters.contains(filter) ? .orange : .white)
                                        .foregroundStyle(selectedFilters.contains(filter) ? .white : .orange)
                                        .clipShape(Capsule())
                                    
                                }.padding(.trailing, 4)
                            }
                        }
                    }.padding(.bottom)
                        .frame(height: 100)
                        .transition(.slide)
                }
            }.padding()
                .animation(.easeInOut, value: isCuisineExpanded)
            
            //diet filters
            VStack(alignment: .leading, spacing: 10){
                Button {
                    withAnimation {
                        isDietExpanded.toggle()
                    }
                } label: {
                    HStack {
                        Text("By Diet")
                            .font(.title3)
                        
                        Spacer()
                        
                        Image(systemName: isDietExpanded ? "chevron.up" : "chevron.down")
                    }
                }.buttonStyle(PlainButtonStyle())
                
                if isDietExpanded{
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, spacing: 5){
                            ForEach(dietFilters) {
                                filter in
                                Button {
                                    toggleFilter(filter)
                                    
                                } label: {
                                    Text(filter.name)
                                        .padding(.horizontal)
                                        .background(selectedFilters.contains(filter) ? .orange : .white)
                                        .foregroundStyle(selectedFilters.contains(filter) ? .white : .orange)
                                        .clipShape(Capsule())
                                    
                                }.padding(.trailing, 4)
                            }
                        }
                    }.padding(.bottom)
                        .frame(height: 100)
                        .transition(.slide)
                }
            }.padding()
                .animation(.easeInOut, value: isDietExpanded)

            //meal type filters
            VStack(alignment: .leading, spacing: 10){
                Button {
                    withAnimation {
                        isMealTypeExpanded.toggle()
                    }
                } label: {
                    HStack {
                        Text("By Meal Type")
                            .font(.title3)
                        
                        Spacer()
                        
                        Image(systemName: isMealTypeExpanded ? "chevron.up" : "chevron.down")
                    }
                }.buttonStyle(PlainButtonStyle())
                
                if isMealTypeExpanded{
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, spacing: 5){
                            ForEach(mealTypeFilters) {
                                filter in
                                Button {
                                    toggleFilter(filter)
                                    
                                } label: {
                                    Text(filter.name)
                                        .padding(.horizontal)
                                        .background(selectedFilters.contains(filter) ? .orange : .white)
                                        .foregroundStyle(selectedFilters.contains(filter) ? .white : .orange)
                                        .clipShape(Capsule())
                                    
                                }.padding(.trailing, 4)
                            }
                        }
                    }.padding(.bottom)
                        .frame(height: 100)
                        .transition(.slide)
                }
            }.padding()
                .animation(.easeInOut, value: isMealTypeExpanded)

            //intolerances filters
            VStack(alignment: .leading, spacing: 10){
                Button {
                    withAnimation {
                        isIntolerancesExpanded.toggle()
                    }
                } label: {
                    HStack {
                        Text("Intolerances")
                            .font(.title3)
                        
                        Spacer()
                        
                        Image(systemName: isIntolerancesExpanded ? "chevron.up" : "chevron.down")
                    }
                }.buttonStyle(PlainButtonStyle())
                
                if isIntolerancesExpanded{
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, spacing: 5){
                            ForEach(intoleranceFilters) {
                                filter in
                                Button {
                                    toggleFilter(filter)
                                    
                                } label: {
                                    Text(filter.name)
                                        .padding(.horizontal)
                                        .background(selectedFilters.contains(filter) ? .orange : .white)
                                        .foregroundStyle(selectedFilters.contains(filter) ? .white : .orange)
                                        .clipShape(Capsule())
                                    
                                }.padding(.trailing, 4)
                            }
                        }
                    }.padding(.bottom)
                        .frame(height: 100)
                        .transition(.slide)
                }
            }.padding()
                .animation(.easeInOut, value: isIntolerancesExpanded)
            
            //Spacer()
            
            //result scrollbview
            ScrollView{
                LazyVStack{
                    ForEach(searchResultRecipe, id: \.id){ recipe in
                        NavigationLink(destination: RecipeInfoView(recipeId: recipe.id)){
                            RecipeSearchResult(recipe: recipe)
                        }
                    }
                }
            }.padding(.bottom, 25)
        }.ignoresSafeArea(edges: .top)
        
    }
    
    private func toggleFilter(_ filter: Filter) {
        if selectedFilters.contains(filter) {
            selectedFilters.remove(filter)
        } else {
            selectedFilters.insert(filter)
        }
    }
    
    private func getSearchResults() async {
        //collapse all filters
        isDietExpanded = false
        isCuisineExpanded = false
        isIntolerancesExpanded = false
        isMealTypeExpanded = false
        
        //empty current search result array
        if !searchResultRecipe.isEmpty{
            searchResultRecipe.removeAll()
        }
        
        //search recipes
        
        do {
            searchResultRecipe = try await ApiManager.shared.searchRecipe(query: searchText, filters: selectedFilters)
            print("Recipe results: \(searchResultRecipe)")
        } catch {
            
            print("error searching recipes: \(error)")
        }
        
        
        //empty search result text and selected filters
        searchText = ""
        selectedFilters.removeAll()
    }
}
 

struct ExploreScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExploreScreen()
    }
}
