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
        .init(name: "All", type: .cuisine),
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
