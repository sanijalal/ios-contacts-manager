//
//  ContactTests.swift
//  ContactsManagerTests
//
//  Created by Sani on 2/8/20.
//  Copyright © 2020 Sani. All rights reserved.
//

import XCTest
@testable import ContactsManager

class ContactTests: XCTestCase {

    func testJsonStringIsEncodedToObjectWithCorrectValues() {
        let jsonString = """
        {
            "id": "5c8a80f5e3d1f2f2967c4621",
            "firstName": "Paula",
            "lastName": "Turner",
            "email": "paulaturner@furnafix.com",
            "phone": "(873) 553-3808"
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        
        let contact = try! JSONDecoder().decode(Contact.self, from: jsonData)
        
        XCTAssertEqual(contact.id, "5c8a80f5e3d1f2f2967c4621")
        XCTAssertEqual(contact.firstName, "Paula")
        XCTAssertEqual(contact.lastName, "Turner")
        XCTAssertEqual(contact.email, "paulaturner@furnafix.com")
        XCTAssertEqual(contact.phone, "(873) 553-3808")
    }
    
    func testJsonStringReturnsNilForOptionalsWhenNoKeyProvided() {
        let jsonString = """
        {
            "id": "5c8a80f5e3d1f2f2967c4621",
            "firstName": "Paula",
            "lastName": "Turner"
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        
        let contact = try! JSONDecoder().decode(Contact.self, from: jsonData)
        
        XCTAssertEqual(contact.id, "5c8a80f5e3d1f2f2967c4621")
        XCTAssertEqual(contact.firstName, "Paula")
        XCTAssertEqual(contact.lastName, "Turner")
        XCTAssertNil(contact.email)
        XCTAssertNil(contact.phone)
    }
    
    func testItemCountCorrect() {
        let jsonString = """
        [
        {
            "id": "5c8a80f5e3d1f2f2967c4621",
            "firstName": "Paula",
            "lastName": "Turner"
        },
        {
            "id": "5c8a80f5e3d1f2f2967c4621",
            "firstName": "Paula",
            "lastName": "Turner"
        }
        ]
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        let contacts = try! JSONDecoder().decode([Contact].self, from: jsonData)
        
        XCTAssertTrue(contacts.count == 2)
    }

}
