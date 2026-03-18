//
//  ContentView.swift
//  Cufi
//
//  Created by Jonathan Lim on 3/17/26.
//

import SwiftUI

struct ContentView: View {
    @State private var sel: Int = 0
    var body: some View {
        NavigationView {
            TabView(selection: $sel) {
                VStack(alignment: .leading) {
                    Text("Filter Coffee Recipies")
                        .font(.title2)
                        .bold()
                        .padding(.leading, 5)
                    ScrollView {
                        NavigationLink(destination: RecipeView(recipe: sampleRecipe)) {
                            RecipeItem(recipe: sampleRecipe)
                        }
                    }
                }
                .padding(.horizontal)
                .tag(0)
                .tabItem {
                    Image(systemName: "cup.and.heat.waves.fill")
                    Text("Filter Recipies")
                }
            }
            .navigationTitle("Cufi")
        }
        .navigationViewStyle(.stack)
    }
}


