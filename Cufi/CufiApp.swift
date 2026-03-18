//
//  CufiApp.swift
//  Cufi
//
//  Created by Jonathan Lim on 3/17/26.
//

import SwiftUI

@main
struct CufiApp: App {
    init() {
        UserDefaults.standard.register(defaults: ["UseFloatingTabBar": false])
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
