//
//  ContactsRetrievalServiceTests.swift
//  ContactsManagerTests
//
//  Created by Sani on 3/7/20.
//  Copyright © 2020 Sani. All rights reserved.
//

import XCTest
@testable import ContactsManager

class ContactsServiceTests: XCTestCase {
    
    private func fileLocation(fileName: String) -> URL? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        
        return url.appendingPathComponent(fileName)
    }
    
    override func setUp() {
        guard let fileUrl = fileLocation(fileName: "contacts") else {
            return
        }
        
        do {
            try FileManager.default.removeItem(at: fileUrl)
        } catch {
            print("Cannot remove file at: \(fileUrl.absoluteString)")
        }
    }
    
    func testRetrieveArrayFromBundleIfJSONFileNotPresent() {
        let contactsService = ContactsService()
        let contacts = contactsService.getContacts()

        XCTAssertTrue(contacts.count == 20)
    }
    
    func testJSONIsWrittenWhenDataIsSaved() {
        let contactsService = ContactsService()
        
        let contacts = [
            Contact(id: "cekodok", firstName: "Cek", lastName: "Dok", email: "cek@dok.com", phone: "1234"),
            Contact(id: "cekodok2", firstName: "Cik", lastName: "Dak", email: "cik@dak.com", phone: "--434")
        ]
        
        let isSaved = contactsService.save(contacts: contacts)
        
        XCTAssertTrue(isSaved)

        guard let pathComponent = fileLocation(fileName: "contacts") else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(FileManager.default.fileExists(atPath: pathComponent.path), "File does not exists")
    }
    
    func testSavedJSONIsAsExpected() {
        let contactsService = ContactsService()
        
        let contacts = [
            Contact(id: "cekodok", firstName: "Cek", lastName: "Dok", email: "cek@dok.com", phone: "1234"),
            Contact(id: "cekodok2", firstName: "Cik", lastName: "Dak", email: "cik@dak.com", phone: "--434")
        ]
        
        let isSaved = contactsService.save(contacts: contacts)
        XCTAssertTrue(isSaved)
        
        guard let pathComponent = fileLocation(fileName: "contacts") else {
            XCTFail()
            return
        }
        
        do {
            let contactString = try String(contentsOf: pathComponent)
            print(contactString)
            XCTAssertTrue(contactString == "[{\"firstName\":\"Cek\",\"id\":\"cekodok\",\"lastName\":\"Dok\",\"email\":\"cek@dok.com\",\"phone\":\"1234\"},{\"firstName\":\"Cik\",\"id\":\"cekodok2\",\"lastName\":\"Dak\",\"email\":\"cik@dak.com\",\"phone\":\"--434\"}]")
            
        } catch {
            XCTFail()
        }
    }
}
