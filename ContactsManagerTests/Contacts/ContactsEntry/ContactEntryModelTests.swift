//
//  ContactEntryModelTests.swift
//  ContactsManagerTests
//
//  Created by Sani on 2/8/20.
//  Copyright © 2020 Sani. All rights reserved.
//

import XCTest
@testable import ContactsManager

class ContactEntryModelTests: XCTestCase {    
    func testModelShouldRetrieveFieldIfAvailable() {
        let model = ContactEntryModel(fields: [EntryGroup(type: .mainInfo,
                                                          fields: [EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: "Nama")])])
        
        let field = model.getEntryType(type: .firstName, group: .mainInfo)
        XCTAssertNotNil(field)
    }
    
    func testModelShouldRetrieveNilIfNotAvailable() {
        let model = ContactEntryModel(fields: [EntryGroup(type: .mainInfo,
                                                          fields: [EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: "Nama")])])
        
        let field = model.getEntryType(type: .lastName, group: .mainInfo)
        XCTAssertNil(field)
    }
    
    func testModelShouldRetrieveNilIfAvailableButGroupIsWrong() {
        let model = ContactEntryModel(fields: [EntryGroup(type: .mainInfo,
                                                          fields: [EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: "Nama")])])
        
        let field = model.getEntryType(type: .lastName, group: .subInfo)
        XCTAssertNil(field)
    }
    
    func testModelShouldBeAbleToSafeAvailableFieldAndReturnTrue() {
        let testValue = "Nama"
        let model = ContactEntryModel(fields: [EntryGroup(type: .mainInfo,
        fields: [EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: "Nama")])])
        
        let isSaved = model.saveFieldFor(type: .firstName, groupType: .mainInfo, value: testValue)
        XCTAssertTrue(isSaved)
        
        // Check if value is saved
        guard let field = model.getEntryType(type: .firstName, group: .mainInfo) else {
            XCTFail("Field not retrieved.")
            return
        }
        
        guard let fieldValue = field.value else {
            XCTFail("Value not retrieved.")
            return
        }
        
        print("Field Value: \(fieldValue)")
        XCTAssert(fieldValue == testValue)
    }
    
    func testFieldIsValidWhenRequiredAndValueIsAvailableReturnsTrue() {
        let model = ContactEntryModel(fields: [EntryGroup(type: .mainInfo,
                                                          fields: [EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: "Nama")])])
        
        let isValid = model.checkEntryIsValid(type: .firstName, group: .mainInfo)
        XCTAssertTrue(isValid)
    }
    
    func testFieldIsNotValidWhenRequiredAndValueIsEmptyReturnsFalse() {
        let model = ContactEntryModel(fields: [EntryGroup(type: .mainInfo,
                                                          fields: [EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: "")])])
        
        let isValid = model.checkEntryIsValid(type: .firstName, group: .mainInfo)
        XCTAssertFalse(isValid)
    }
    
    func testFieldIsNotValidWhenRequiredAndValueIsNilReturnsFalse() {
        let model = ContactEntryModel(fields: [EntryGroup(type: .mainInfo,
                                                          fields: [EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: nil)])])
        
        let isValid = model.checkEntryIsValid(type: .firstName, group: .mainInfo)
        XCTAssertFalse(isValid)
    }
    
    func testFieldIsNotValidWhenNotRequiredAndValueIsAvailableReturnsTrue() {
        let model = ContactEntryModel(fields: [EntryGroup(type: .mainInfo,
                                                          fields: [EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: "Nama")])])
        
        let isValid = model.checkEntryIsValid(type: .firstName, group: .mainInfo)
        XCTAssertTrue(isValid)
    }
    
    func testFieldIsNotValidWhenNotRequiredAndValueIsEmptyReturnsTrue() {
        let model = ContactEntryModel(fields: [EntryGroup(type: .mainInfo,
                                                          fields: [EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: "Nama")])])
        
        let isValid = model.checkEntryIsValid(type: .firstName, group: .mainInfo)
        XCTAssertTrue(isValid)
    }
    
    func testFieldIsNotValidWhenNotRequiredAndValueIsNilReturnsTrue() {
        let model = ContactEntryModel(fields: [EntryGroup(type: .mainInfo,
                                                          fields: [EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: "Nama")])])
        
        let isValid = model.checkEntryIsValid(type: .firstName, group: .mainInfo)
        XCTAssertTrue(isValid)
    }
    
    func testIsValidWhenModelNotValidReturnsFalse() {
        let model = ContactEntryModel(fields: [EntryGroup(type: .mainInfo,
                                                          fields: [
                                                            EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: nil),
                                                            EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: "Nama")
        ])])
        
        XCTAssertFalse(model.isValid())
    }
    
    func testIsValidWhenModelNotValidReturnsTrue() {
        let model = ContactEntryModel(fields: [EntryGroup(type: .mainInfo,
                                                          fields: [
                                                            EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: "Nama"),
                                                            EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: "Nama")
        ])])
        
        XCTAssertTrue(model.isValid())
    }
}
