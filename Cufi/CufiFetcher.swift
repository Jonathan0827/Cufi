//
//  CufiFetcher.swift
//  Cufi
//
//  Created by Jonathan Lim on 3/19/26.
//

import Foundation
import Alamofire

func cufiVersion(completion: @escaping (String) -> Void) {
    let domain = "\(getUserDefaults("server"))"
    if domain.isEmpty {
        completion("Server is not configured.")
    } else {
        AF.request("\(domain)/cufiVersion")
            .response { response in
                if let data = response.data, let version = String(data: data, encoding: .utf8) {
                    completion(version)
                }
            }
    }
}

func cufiList(completion: @escaping ([Recipe]) -> Void) {
    let domain = "\(getUserDefaults("server"))"
    if domain.isEmpty {
        completion([])
    } else {
        AF.request("\(domain)/recipes", method: .get)
            .responseDecodable(of: Array<Recipe>.self) { response in
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(let e):
                    print(e)
                }
            }
    }
}

func updateCufi(_ nr: Recipe, completion: @escaping (String) -> Void) {
    let domain = "\(getUserDefaults("server"))"
    if domain.isEmpty {
        completion("Server is not configured.")
    } else {
        var body = nr.toDict
//        body!["_id"] = UUID().uuidString
        AF.request("\(domain)/recipes/update", method: .post, parameters: body, encoding: JSONEncoding.default)
            .response { response in
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print(str)
                    completion(str)
                }
            }
    }
}

