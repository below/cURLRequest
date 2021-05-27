//
//  Data+PrettyJSON.swift
//  
//
//  Created by Alexander v. Below on 27.05.21.
//

import Foundation

internal extension Data {
    func prettyJSON () throws -> String {
         let jsonObject = try JSONSerialization.jsonObject(with: self, options: [])
            let prettyJSON = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            return String(data: prettyJSON, encoding: .utf8)!
    }
}
