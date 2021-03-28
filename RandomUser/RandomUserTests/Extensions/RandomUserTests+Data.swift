//
//  RandomUserTests+Data.swift
//  RandomUserTests
//
//  Created by Daniel Esteban Salinas on 27/03/21.
//

import Foundation
import XCTest

extension Data {
    
    public static func fromJSON(fileName: String) throws -> Data {
        let url = try XCTUnwrap(Bundle(for: TestBundleClass.self).url(forResource: fileName, withExtension: "json"))
        let data = try Data(contentsOf: url)
        return data
    }
    
}

private class TestBundleClass { }
