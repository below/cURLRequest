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
                    command.append(" \\\n\t")
                    command.append("-H '\(key): \(value)'")
                }
            }

//            if let bodyData = self.httpBody {
//                do {
//                    let jsonObject = try JSONSerialization.jsonObject(with: bodyData, options: [])
//                    let prettyJSON = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
//                    let prettyString = String(data: prettyJSON, encoding: .utf8)
//                } catch {
//
//                }
//            }

            return command
        }
    }
}
