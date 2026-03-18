//
//  RecipeList.swift
//  Cufi
//
//  Created by Jonathan Lim on 3/17/26.
//

import SwiftUI
import Foundation

struct RecipeItem: View {
    let recipe: Recipe
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(Font.title.bold())
                    .foregroundColor(.primary)
                Text("Bean: \(recipe.beanQty)g, Water: \(recipe.waterQty)ml, Duration: \(recipe.brewDuration)s, Dripper: \(recipe.dripper)")
                    .foregroundStyle(Color.secondary)
            }
            .padding()
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.secondary)
                .padding()
        }
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(uiColor: UIColor.systemGray6))
        }
    }
}

struct Recipe: Identifiable, Codable {
    let title: String
    let id: String
    let beanQty: Int
    let waterQty: Int
    let brewDuration: Int
    let dripper: String
    let temp: Int
    let steps: [Step]
}
struct Step: Codable {
    let what: String
    let duration: Int
    let qty: Int
}
let sampleRecipe: Recipe = Recipe(title: "안스타 6888", id: "1", beanQty: 20, waterQty: 300, brewDuration: 140, dripper: "Hario V60", temp: 92, steps: realSteps)
let realSteps = [Step(what: "Blooming", duration: 30, qty: 60), Step(what: "Pour #1", duration: 30, qty: 80), Step(what: "Pour #2", duration: 30, qty: 80), Step(what: "Pour #3", duration: 30, qty: 80), Step(what: "Wait for the finish", duration: 30, qty: 80)]
let simpleSteps = [Step(what: "Brew", duration: 10, qty: 200)]
