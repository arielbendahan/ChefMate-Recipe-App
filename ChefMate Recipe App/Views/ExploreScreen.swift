//
//  ExploreScreen.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-03-12.
//
 
import SwiftUI
 
struct ExploreScreen: View {
    @State var searchText = ""
    var body: some View {
        VStack (alignment: .leading){
            Text("Explore")
                .font(.title)
                .bold()
                .foregroundStyle(.orange)
                .padding()
            
            HStack(spacing: 10){
                
                TextField("Search recipe...", text: $searchText)
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(radius: 5)
                
                Image(systemName: "magnifyingglass.circle")
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
