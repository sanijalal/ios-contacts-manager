//
//  ContactsManagerUITests.swift
//  ContactsManagerUITests
//
//  Created by Sani on 2/8/20.
//  Copyright © 2020 Sani. All rights reserved.
//

import XCTest

class ContactsEntryViewControllerUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    private func waitForOtherElementAndFailIfNotShown(app: XCUIApplication, identifier: String) {
        if (app.otherElements[identifier].waitForExistence(timeout: 20)) == false {
            XCTFail("\(identifier) is not shown")
        }
    }
    
    func testContactDetailsPageContainsFourLabels() {
        let nameToTest = "Phoebe Monroe"
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.tables.cells.containing(.staticText, identifier:nameToTest).element.tap()
        waitForOtherElementAndFailIfNotShown(app: app, identifier: "TopHeaderView")
        XCTAssertTrue(app.tables.cells.count == 4, "The number of cells displayed is not 4, it is \(app.tables.cells.count)")
    }
    
    func testWhenNameIsSelectedAllFieldsAreShownCorrectly() {
        let nameToTest = "Phoebe Monroe"
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.tables.cells.containing(.staticText, identifier:nameToTest).element.tap()
        waitForOtherElementAndFailIfNotShown(app: app, identifier: "TopHeaderView")
        let texts = app.staticTexts.containing(.staticText, identifier: "cellTitle")
        XCTAssertTrue(texts.element(boundBy: 0).label == "First Name")
        XCTAssertTrue(texts.element(boundBy: 1).label == "Last Name")
        XCTAssertTrue(texts.element(boundBy: 2).label == "Email")
        XCTAssertTrue(texts.element(boundBy: 3).label == "Phone Number")
    }
    
    func testWhenNameIsSelectedDetailsAreShownCorrectly() {
        let nameToTest = "Phoebe Monroe"
        let app = XCUIApplication()
        app.launch()

        app.tables.cells.containing(.staticText, identifier:nameToTest).element.tap()
        waitForOtherElementAndFailIfNotShown(app: app, identifier: "TopHeaderView")
        let texts = app.textFields.containing(.textField, identifier: "cellField")
        XCTAssertTrue(texts.element(boundBy: 0).value as! String == "Phoebe")
        XCTAssertTrue(texts.element(boundBy: 1).value as! String == "Monroe")
        XCTAssertTrue(texts.element(boundBy: 2).value as! String == "phoebemonroe@furnafix.com")
        XCTAssertTrue(texts.element(boundBy: 3).value as! String == "(903) 553-3410")
    }
}
