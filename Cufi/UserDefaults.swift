//
//  UserDefaults.swift
//  Cufi
//
//  Created by Jonathan Lim on 3/19/26.
//

import Foundation

func getUserDefaults(_ key: String) -> Any {
    return UserDefaults.standard.value(forKey: key) ?? ""
}

func setUserDefaults(_ key: String, _ value: Any) {
    UserDefaults.standard.setValue(value, forKey: key)
}

func saveRecipes(_ r: [Recipe]) {
    let pEncoder = PropertyListEncoder()
    let encodedData = try! pEncoder.encode(r)
    setUserDefaults("cufiList", encodedData)
}
func readRecipes() -> [Recipe] {
    let pDecoder = PropertyListDecoder()
    let encodedData = getUserDefaults("cufiList") as! Data
    return try! pDecoder.decode([Recipe].self, from: encodedData)
}
