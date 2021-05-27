//
//  URLEncodingTests.swift
//  
//
//  Created by Alexander v. Below on 27.05.21.
//

import XCTest
@testable import cURLRequest

final class URLEncodingTests: XCTestCase {
    
    func testURLEcoding() {
        let inputData = "foo=bar&faz=baz&flim=flam".data(using: .utf8)!
        
        do {
            let parameters = try inputData.urlEncodedParameters()
            
            let expected = ["foo":"bar","faz":"baz","flim":"flam"]
            XCTAssertEqual(expected, parameters)
        } catch {
            XCTFail("Unable to get parameters")
        }
    }
    
    func testNoURLEncoding() {
        let inputData = #"{"foo":"bar","faz":"baz"}"#.data(using: .utf8)!
        XCTAssertThrowsError(try inputData.urlEncodedParameters())
    }
}
