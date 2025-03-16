//
//  HomeView.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-03-06.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView{
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 100) // Adjust height as needed
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 3)
                        .ignoresSafeArea()
                    
                    
                    HStack {
                        Text("ChefMate")
                            .font(.title)
                            .bold()
                            .foregroundColor(.orange)
                            .padding(.leading)
                            .padding(.bottom, 50)
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                HStack {
                    Text("Featured Recipes")
                        .font(.title2)
                        .bold()
                        .padding(.leading)
                    Spacer()
                }
                RecipeScrollView()
                Divider()
                    .frame(width: 300)
                    .padding()
                HStack {
                    Text("Trending Recipes")
                        .font(.title2)
                        .bold()
                        .padding(.leading)
                    Spacer()
                }
                // DO NOT UNCOMMENT OR TURN OFF PREVIEWS BECAUSE THIS WILL DRAIN THE API LIMIT FOR THE DAY
                //RecipeScrollView()
                Divider()
                    .frame(width: 300)
                    .padding()
                HStack {
                    Text("Favourited Recipes")
                        .font(.title2)
                        .bold()
                        .padding(.leading)
                    Spacer()
                }
                // DO NOT UNCOMMENT OR TURN OFF PREVIEWS BECAUSE THIS WILL DRAIN THE API LIMIT FOR THE DAY
                //RecipeScrollView()
                
                Spacer()
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
