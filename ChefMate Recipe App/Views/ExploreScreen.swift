//
//  ExploreScreen.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-03-12.
//
 
import SwiftUI
 
struct ExploreScreen: View {
    @State var searchText = ""
    
    var cuisineFilters: [Filter] = [
        .init(name: "All", id: 1), .init(name: "African", id: 2), .init(name: "Asian", id: 3), .init(name: "American", id: 4), .init(name: "British", id: 5), .init(name: "Cajun", id: 5), .init(name: "Caribbean", id: 6), .init(name: "Chinese", id: 7), .init(name: "Eastern European", id: 8), .init(name: "European", id: 9), .init(name: "French", id: 10), .init(name: "German", id: 11), .init(name: "Greek", id: 12), .init(name: "Indian", id: 13), .init(name: "Irish", id: 14), .init(name: "Italian", id: 15), .init(name: "Japanese", id: 16), .init(name: "Jewish", id: 17), .init(name: "Jewish", id: 18), .init(name: "Korean", id: 19), .init(name: "Latin American", id: 20), .init(name: "Mediterranean", id: 21), .init(name: "Mexican", id: 22), .init(name: "Middle Eastern", id: 23), .init(name: "Nordic", id: 24), .init(name: "Southern", id: 25), .init(name: "Spanish", id: 26), .init(name: "Thai", id: 27), .init(name: "Vietnamese", id: 28),
        
    ]
    
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
                    HStack{
                        ForEach(cuisineFilters, id: \.id) {
                            filter in
                            // filter is constant
                            var item = filter
                            Button {
                                print("filter: \(filter.name.lowercased())")
                                item.switchIsSelected()
                            } label: {
                                Text(filter.name)
                                    .padding(.horizontal)
                                    .background(.orange)
                                    .foregroundStyle(.white)
                                    .clipShape(Capsule())
                                    
                            }.padding(.trailing, 4)
                        }
                    }
                }.padding(.bottom)
                
                Text("By Diet")
                    .font(.title3)
                
                
                Text("By Meal Type")
                    .font(.title3)
                
            }.padding()
            
            Spacer()
            
            
            
            
        }
    }
}
 

struct ExploreScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExploreScreen()
    }
}
