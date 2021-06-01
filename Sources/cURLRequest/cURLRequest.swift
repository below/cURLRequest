/*

MIT License

Copyright (c) 2021 Alexander von Below

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import Foundation

public extension URLRequest {

    var curlCommand: String {
        get {
            var command = "curl "

            guard let method = self.httpMethod?.uppercased() else {
                return "# No HTTP Method found"
            }
            if (method != "GET") {
                command.append("-X \(method) ")
            }

            guard let url = self.url?.absoluteString else {
                return "# No URL found"
            }
            command.append(url)

            if let headers = self.allHTTPHeaderFields
            {
                for (key, value) in headers {
                    command.append(" \\\\\n\t-H \"\(key): \(value)\"")
                }
            }

            if let bodyData = self.httpBody {

                if let prettyJsonString = try? bodyData.prettyJSON() {
                    let commandLineString = prettyJsonString.replacingOccurrences(of: "\"", with: "\\\"")
                    command.append(" \\\\\n -d \"\(commandLineString)\"")

                } else if let urlEncodedParams = try? bodyData.urlEncodedParameters() {

                    for (key, value) in urlEncodedParams {
                        command.append(" \\\\\n\t--data-urlencode \"\(key)=\(value)\"")
                    }

                } else if let bodyString = String(data: bodyData, encoding: .utf8)
                {
                    command.append(" \\\\\n\t--data-binary \"\(bodyString)\"")

                } else {
                    command.append("\n\t# Unable to pass body data")

                }
            }

            return command
        }
    }
}

