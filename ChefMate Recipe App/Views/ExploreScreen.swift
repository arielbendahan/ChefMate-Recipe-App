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
    
    var cuisineFilters: [CuisineFilter] = [
        .init(name: "All"),
        .init(name: "African"),
        .init(name: "Asian"),
        .init(name: "American"),
        .init(name: "British"),
        .init(name: "Cajun"),
        .init(name: "Caribbean"),
        .init(name: "Chinese"),
        .init(name: "Eastern European"),
        .init(name: "European"),
        .init(name: "French"),
        .init(name: "German"),
        .init(name: "Greek"),
        .init(name: "Indian"),
        .init(name: "Irish"),
        .init(name: "Italian"),
        .init(name: "Japanese"),
        .init(name: "Jewish"),
        .init(name: "Jewish"),
        .init(name: "Korean"),
        .init(name: "Latin American"),
        .init(name: "Mediterranean"),
        .init(name: "Mexican"),
        .init(name: "Middle Eastern"),
        .init(name: "Nordic"),
        .init(name: "Southern"),
        .init(name: "Spanish"),
        .init(name: "Thai"),
        .init(name: "Vietnamese"),
    ]
    
    @State private var selectedFilters: Set<Filter> = []
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Explore")
                .font(.title)
                .bold()
                .foregroundStyle(.orange)
                .padding()
            
            HStack(spacing: 10){
                
                TextField("Search recipe...", text: $searchText)
                    .padding(7)
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(radius: 8, y: 5)
                
                Button {
                    print("search button")
                } label: {
                    Image(systemName: "magnifyingglass.circle")
                        .font(.title)
                        .foregroundStyle(.orange)
                }
            }.padding()
            
            Text("Filters")
                .font(.title2)
                .bold()
                .padding()
            
            VStack(alignment: .leading, spacing: 10){
                Text("By Cuisine")
                    .font(.title3)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, spacing: 5){
                        ForEach(cuisineFilters) {
                            filter in
                            Button {
                                toggleFilter(filter)
                                
                            } label: {
                                Text(filter.name)
                                    .padding(.horizontal)
                                    .background(selectedFilters.contains(filter) ? .white : .orange)
                                    .foregroundStyle(selectedFilters.contains(filter) ? .orange : .white)
                                    .clipShape(Capsule())
                                    
                            }.padding(.trailing, 4)
                        }
                    }
                }.padding(.bottom)
                    .frame(height: 100)
                
                Text("By Diet")
                    .font(.title3)
                
                
                Text("By Meal Type")
                    .font(.title3)
                
            }.padding()
            
            Spacer()
            
            
            
            
        }
        
    }
    
    private func toggleFilter(_ filter: Filter) {
        if selectedFilters.contains(filter) {
            selectedFilters.remove(filter)
        } else {
            selectedFilters.insert(filter)
        }
    }
}
 

struct ExploreScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExploreScreen()
    }
}
