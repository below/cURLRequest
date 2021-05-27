//
//  JSONTests.swift
//  
//
//  Created by Alexander v. Below on 27.05.21.
//

import XCTest
@testable import cURLRequest

final class JSONTests: XCTestCase {

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

    func testNoJSON() {
        let inputData = "foo=bar&faz=baz&flim=flam".data(using: .utf8)!
        XCTAssertThrowsError(try inputData.prettyJSON())
    }
}
