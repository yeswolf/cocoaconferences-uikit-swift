//
//  CocoaConferencesUITests.swift
//  CocoaConferencesUITests
//
//  Created by jetbrains on 2019-01-18.
//  Copyright © 2019 JetBrains. All rights reserved.
//

import XCTest

class CocoaConferencesUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testTwoItems() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["🇮🇹 Bologna, Italy"]/*[[".cells.staticTexts[\"🇮🇹 Bologna, Italy\"]",".staticTexts[\"🇮🇹 Bologna, Italy\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Pragma Conference"].buttons["Conferences"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["try! Swift NYC 2019"]/*[[".cells.staticTexts[\"try! Swift NYC 2019\"]",".staticTexts[\"try! Swift NYC 2019\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["try! Swift NYC 2019"].buttons["Conferences"].tap()

    }

}
