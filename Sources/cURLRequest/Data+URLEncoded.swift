//
//  Data+URLEncoded.swift
//  
//
//  Created by Alexander v. Below on 27.05.21.
//

import Foundation

internal extension Data {
    enum URLEncodedParameterError: Error {
        case notAString
        case notURLEncoded
        case unableToParse
    }

    func urlEncodedParameters() throws -> [String: String] {
        guard let input = String(data: self, encoding: .utf8) else {
            throw URLEncodedParameterError.notAString
        }

        let regex = try NSRegularExpression(pattern: ".+=.+(&.+=.+)*", options: [])

        let substringRange = input.startIndex..<input.endIndex

        guard regex.firstMatch(in: input, options: [], range: NSRange(substringRange, in: input)) != nil else {
            throw URLEncodedParameterError.notURLEncoded
        }

        var result = [String:String]()

        for parameter in input.split(separator: "&") {
            let keyValue = parameter.split(separator: "=", maxSplits: 1)
            guard keyValue.count == 2 else {
                throw URLEncodedParameterError.unableToParse
            }
            let key = String(keyValue[0])
            let value = String(keyValue[1])
            result[key] = value
        }
        return result
    }
}
