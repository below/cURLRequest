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

