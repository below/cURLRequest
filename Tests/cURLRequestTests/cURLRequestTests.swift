    import XCTest
    @testable import cURLRequest

    final class cURLRequestTests: XCTestCase {
        func testSimpleURL() {
            let urlRequest = URLRequest(url: URL(string: "https://example.com")!)

            let result = urlRequest.curlCommand
            XCTAssertEqual(result, "curl https://example.com")
        }

        func testPostURL() {
            var urlRequest = URLRequest(url: URL(string: "https://example.com")!)
            urlRequest.httpMethod = "POST"

            let result = urlRequest.curlCommand
            XCTAssertEqual(result, "curl -X POST https://example.com")

        }

        func testHeaders() {
            var urlRequest = URLRequest(url: URL(string: "https://example.com")!)
            urlRequest.setValue("123456", forHTTPHeaderField: "Authorization")
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")

            let result = urlRequest.curlCommand
            let expected1 = "curl https://example.com \\\\\n\t-H \"Authorization: 123456\" \\\\\n\t-H \"Content-Type: application/x-www-form-urlencoded; charset=utf-8\""
            let expected2 = "curl https://example.com \\\\\n\t-H \"Content-Type: application/x-www-form-urlencoded; charset=utf-8\" \\\\\n\t-H \"Authorization: 123456\""

            let matches1 = expected1 == result
            if matches1 {
                print ("First variant matches")
            }
            let matches2 = expected2 == result
            if matches2 {
                print ("Second variant matches")
            }

            XCTAssertTrue(matches1 || matches2)
        }

        func testJSONRequest() {

            let requestData = #"{"foo":"bar","faz":"baz"}"#.data(using: .utf8)!
            var request = URLRequest(url: URL(string: "https://example.com")!)
            request.httpMethod = "POST"
            request.httpBody = requestData

            let result = request.curlCommand

            let expected = "curl -X POST https://example.com \\\\\n -d \"{\n  \\\"foo\\\" : \\\"bar\\\",\n  \\\"faz\\\" : \\\"baz\\\"\n}\""

            XCTAssertEqual(expected, result)
        }

        func testURLEncodedParamRequest () {
            var request = URLRequest(url: URL(string: "https://example.com")!)
            request.httpMethod = "POST"

            var urlComponents = URLComponents()
            urlComponents.queryItems =  [ URLQueryItem(name: "foo", value: "bar") ]
            request.httpBody = urlComponents.percentEncodedQuery?.data(using: .utf8)
            let result = request.curlCommand

            let expected = "curl -X POST https://example.com \\\\\n\t--data-urlencode \"foo=bar\""
            XCTAssertEqual(expected, result)
        }

    }
