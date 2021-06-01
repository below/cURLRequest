/*

MIT License

Copyright (c) 2021 Alexander von Below

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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
