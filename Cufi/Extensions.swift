//
//  Extensions.swift
//  Cufi
//
//  Created by Jonathan Lim on 3/19/26.
//

import Foundation
import Alamofire

extension Encodable {
    
    var toDict : [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:Any] else { return nil }
        return dictionary
    }
}

extension DataRequest {
    func printStr() -> DataRequest {
        self.response { response in
            if let data = response.data, let str = String(data: data, encoding: .utf8) {
                print(str)
            }
        }
        return self
    }
}
