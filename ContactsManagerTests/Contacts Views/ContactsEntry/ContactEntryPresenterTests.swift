//
//  ContactEntryPresenterTests.swift
//  ContactsManagerTests
//
//  Created by Sani on 2/9/20.
//  Copyright © 2020 Sani. All rights reserved.
//

import XCTest
@testable import ContactsManager

class ContactEntryPresenterTests: XCTestCase {

    private func createPresenter() -> ContactEntryPresenter {
        let presenter = ContactEntryPresenter(model: ContactEntryModel(fields: [
            EntryGroup(type: .mainInfo, fields: [
                EntryField(type: .firstName, isRequired: true, keyboardType: .namePhonePad, capitalizationType: .words, value: ""),
                EntryField(type: .lastName, isRequired: true, keyboardType: .namePhonePad, capitalizationType: .words, value: ""),
            ]),
            EntryGroup(type: .subInfo, fields: [
                EntryField(type: .email, isRequired: false, keyboardType: .namePhonePad, capitalizationType: .words, value: "")
            ])
        ], id: "sani"))
        
        return presenter
    }
    
    func testReturnCorrectNumberOfGroups() {
        let presenter = createPresenter()
        XCTAssertTrue(presenter.groupCount() == 2)
    }
    
    func testReturnCorrectNumberOfFieldsForAGivenGroup() {
        let presenter = createPresenter()
        XCTAssertTrue(presenter.rowCountFor(section: 0) == 2)
        XCTAssertTrue(presenter.rowCountFor(section: 1) == 1)
    }
    
    func testReturnSameModelValuesAsExpected() {
        let presenter = createPresenter()
        let model = presenter.model(atPath: IndexPath(row: 0, section: 0))
        
        let compareModel = EntryField(type: .firstName, isRequired: true, keyboardType: .namePhonePad, capitalizationType: .words, value: "")
        
        XCTAssertTrue(model?.type == compareModel.type)
        XCTAssertTrue(model?.value == compareModel.value)
        XCTAssertTrue(model?.isRequired == compareModel.isRequired)
    }
    
    func testReturnCorrectTitleForGroup() {
        let presenter = createPresenter()
        
        XCTAssertTrue(presenter.titleForGroupAt(index: 0) == EntryGroupType.mainInfo.rawValue)
        XCTAssertTrue(presenter.titleForGroupAt(index: 1) == EntryGroupType.subInfo.rawValue)
    }
    
    func testIsValidateReturnsTrueWhenAllFieldsAreCorrect() {
        let presenter = ContactEntryPresenter(model: ContactEntryModel(fields: [
            EntryGroup(type: .mainInfo, fields: [
                EntryField(type: .firstName, isRequired: true, keyboardType: .namePhonePad, capitalizationType: .words, value: "Sani"),
                EntryField(type: .lastName, isRequired: true, keyboardType: .namePhonePad, capitalizationType: .words, value: "Jo"),
            ]),
            EntryGroup(type: .subInfo, fields: [
                EntryField(type: .email, isRequired: false, keyboardType: .namePhonePad, capitalizationType: .words, value: "")
            ])
        ], id: "sani"))
        
        XCTAssertTrue(presenter.validateFields())
    }
    
    func testIsValidateReturnsFalseWhenRequiredFieldsAreMissing() {
        let presenter = ContactEntryPresenter(model: ContactEntryModel(fields: [
            EntryGroup(type: .mainInfo, fields: [
                EntryField(type: .firstName, isRequired: true, keyboardType: .namePhonePad, capitalizationType: .words, value: "Sani"),
                EntryField(type: .lastName, isRequired: true, keyboardType: .namePhonePad, capitalizationType: .words, value: ""),
            ]),
            EntryGroup(type: .subInfo, fields: [
                EntryField(type: .email, isRequired: false, keyboardType: .namePhonePad, capitalizationType: .words, value: "")
            ])
        ], id: "sani"))
        
        XCTAssertFalse(presenter.validateFields())
    }
    
    func testSaveReturnsTrueWhenGivenFieldExists() {
        let presenter = createPresenter()
        
        XCTAssertTrue(presenter.saveEntryFor(type: .email, group: .subInfo, value: "test@mail.com"))
    }
    
    func testSaveReturnsFalseWhenGivenFieldDoesNotExists() {
        let presenter = createPresenter()
        
        XCTAssertFalse(presenter.saveEntryFor(type: .phoneNumber, group: .mainInfo, value: "test@mail.com"))
    }

}
