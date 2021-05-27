    import XCTest
    @testable import cURLRequest

    final class cURLRequestTests: XCTestCase {

        func testPrettyJSON() {

            let inputData = #"{"foo":"bar","faz":"baz"}"#.data(using: .utf8)!
            do {
            let prettyString = try inputData.prettyJSON()
            let expected = "{\n  \"foo\" : \"bar\",\n  \"faz\" : \"baz\"\n}"
            XCTAssertEqual(expected, prettyString)
            } catch {
                XCTFail("Unable to convert")
            }
        }
    }
