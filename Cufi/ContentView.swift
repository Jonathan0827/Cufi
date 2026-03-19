//
//  ContentView.swift
//  Cufi
//
//  Created by Jonathan Lim on 3/17/26.
//

import SwiftUI

struct ContentView: View {
    @State private var sel: Int = 0
    @AppStorage("cufiVersion") var version: String = ""
    var body: some View {
        let cufiList: Array<Recipe> = readRecipes()
        TabView(selection: $sel) {
            NavigationView {
                
                VStack(alignment: .leading) {
                    Text("Cufi")
                        .font(.largeTitle.bold())
                        .padding(.leading, 5)
                    Text("Filter Coffee Recipes")
                        .font(.title2)
                        .bold()
                        .padding(.leading, 5)
                    Text("Recipe Version: \(version)")
                        .font(.caption2.bold())
                        .foregroundStyle(.secondary)
                        .padding(.leading, 5)
                    Button("test", action: {
                        updateCufi(sampleRecipe) { r in
                            print(r)
                        }
                    })
                    ScrollView {
                        ForEach(cufiList, id: \.title) { recipe in
                            NavigationLink(destination: RecipeView(recipe: recipe)) {
                                RecipeItem(recipe: recipe)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .tag(0)
            .tabItem {
                Image(systemName: "cup.and.heat.waves.fill")
                Text("Filter Recipes")
            }
            .navigationViewStyle(.stack)
        }
        
    }
}


