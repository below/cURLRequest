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

        func testHeadres() {
            var urlRequest = URLRequest(url: URL(string: "https://example.com")!)
            urlRequest.setValue("123456", forHTTPHeaderField: "Authorization")
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")

            let result = urlRequest.curlCommand
            let expected1 = "curl https://example.com \\\n\t-H \'Authorization: 123456\' \\\n\t-H \'Content-Type: application/x-www-form-urlencoded; charset=utf-8\'"
            let expected2 = "curl https://example.com \\\n\t-H \'Content-Type: application/x-www-form-urlencoded; charset=utf-8\' \\\n\t-H \'Authorization: 123456\'"

            let matches1 = expected1 == result
            let matches2 = expected2 == result

            XCTAssertTrue(matches1 || matches2)
        }
    }
