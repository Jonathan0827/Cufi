//
//  RecipeView.swift
//  Cufi
//
//  Created by Jonathan Lim on 3/17/26.
//

import SwiftUI
internal import Combine

struct RecipeView: View {
    let recipe: Recipe
    @State var currentOrientation = UIDevice.current.orientation
    private let orientationChangedNotification = NotificationCenter.default
        .publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
    var body: some View {
        let columns: [GridItem] = currentOrientation.rawValue == 1 || currentOrientation.rawValue == 2 ? [GridItem(.flexible())] :  [GridItem(.flexible()), GridItem(.flexible())]
        ScrollView {
            LazyVGrid(columns: columns) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(uiColor: .systemGray6))
                .aspectRatio(1.0, contentMode: .fit)
                .padding(5)
                .overlay(alignment: .center) {
                    TimerView(recipe: recipe)
                        .padding(50)
                }
                Grid {
                    GridRow {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color(uiColor: .systemGray6))
                            .frame(height: 100)
                            .overlay(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Label("Water", systemImage: "drop.halffull")
                                        .font(.title3.bold())
                                        .foregroundStyle(.blue)
                                    Text("\(recipe.waterQty)ml")
                                        .font(.title.bold())
                                }
                                .padding(.leading)
                            }
                            .padding(5)
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color(uiColor: .systemGray6))
                            .frame(height: 100)
                            .overlay(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Label("Coffee", systemImage: "circle.lefthalf.filled")
                                        .font(.title3.bold())
                                        .foregroundStyle(.brown)
                                    Text("\(recipe.beanQty)g")
                                        .font(.title.bold())
                                }
                                .padding(.leading)
                            }
                            .padding(5)
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color(uiColor: .systemGray6))
                            .frame(height: 100)
                            .overlay(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Label("Ratio", systemImage: "percent")
                                        .font(.title3.bold())
                                    Text("1:\(recipe.waterQty/recipe.beanQty)")
                                        .font(.title.bold())
                                }
                                .padding(.leading)
                            }
                            .padding(5)
                    }
                    HStack {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color(uiColor: .systemGray6))
                            .frame(height: 100)
                            .overlay(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Label("Temprature", systemImage: "thermometer.medium")
                                        .font(.title3.bold())
                                        .foregroundStyle(.red)
                                    Text("\(recipe.temp)°C")
                                        .font(.title.bold())
                                }
                                .padding(.leading)
                            }
                            .padding(5)
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color(uiColor: .systemGray6))
                            .frame(height: 100)
                            .overlay(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Label("Duration", systemImage: "clock.arrow.trianglehead.clockwise.rotate.90.path.dotted")
                                        .font(.title3.bold())
                                    Text("\(recipe.brewDuration)s")
                                        .font(.title.bold())
                                }
                                .padding(.leading)
                            }
                            .padding(5)
                    }
                    HStack {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color(uiColor: .systemGray6))
                            .frame(height: 100)
                            .overlay(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Label("Dripper", systemImage: "field.of.view.wide.fill")
                                        .font(.title3.bold())
                                    Text("\(recipe.dripper)")
                                        .font(.title.bold())
                                }
                                .padding(.leading)
                            }
                            .padding(5)
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color(uiColor: .systemGray6))
                            .frame(height: 100)
                            .overlay(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Label("Last Updated", systemImage: "calendar")
                                        .font(.title3.bold())
                                    Text("\(recipe.lastUpdated)")
                                        .font(.title.bold())
                                }
                                .padding(.leading)
                            }
                            .padding(5)
                    }
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 80)
        .padding(.top)
        .navigationTitle("\(recipe.title)")
        .onReceive(orientationChangedNotification) { _ in
            if UIDevice.current.orientation.rawValue <= 4 {
                self.currentOrientation = UIDevice.current.orientation
            }
        }
    }
}
