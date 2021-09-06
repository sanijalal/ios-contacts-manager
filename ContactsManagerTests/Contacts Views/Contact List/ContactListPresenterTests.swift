//
//  ContactListPresenterTests.swift
//  ContactsManagerTests
//
//  Created by Abd Sani Abd Jalal on 06/09/2021.
//  Copyright © 2021 Sani. All rights reserved.
//

import XCTest
@testable import ContactsManager

class ContactListPresenterTests: XCTestCase {

    private func defaultPresenter(model: ContactListModel? = nil) -> ContactListPresenter {
        if let contactModel = model {
            return ContactListPresenter(model: contactModel)
        } else {
            return ContactListPresenter(model: defaultContactListModel())
        }
    }
    
    private func defaultContactListModel() -> ContactListModel {
        let contact = Contact(id: "1",
                              firstName: "First",
                              lastName: "Name",
                              email: "a@bba.com",
                              phone: "1234")
        return ContactListModel(contacts: [contact])
    }

    

    func testCountReturnCorrectNumberOfModels() throws {
        let presenter = defaultPresenter()
        XCTAssertTrue(presenter.numberOfContacts() == 1, "Number of contacts is not 1 when 1 is expected")
    
        let contact1 = Contact(id: "2", firstName: "sd", lastName: "dsad", email: "dsadsa", phone: "dsada")
        let contact2 = Contact(id: "3", firstName: "sd", lastName: "dsad", email: "dsadsa", phone: "dsada")
        let contactModel = ContactListModel(contacts: [contact1, contact2])
        let presenterWithManyContacts = defaultPresenter(model: contactModel)
        
        XCTAssertTrue(presenterWithManyContacts.numberOfContacts() == 2, "Number of contacts is not 2 when expected is 2")
    }
    
    func testRetrieveContactOutsideBoundsReturnNil() {
        let presenter = defaultPresenter()
        let contact = presenter.getContactAt(row: 12)
        
        XCTAssertTrue(contact == nil, "Contact retrieved is not nil when retrieving outside of bounds")
    }
    
    func testRetrieveContactInsideBoundsReturnContact() {
        
        let testId = "bibobi"
        let firstName = "Elle"
        let lastName = "Kemper"
        let email = "ellie@kemper.com"
        let phone = "12334"
        
        let contact = Contact(id: testId, firstName: firstName, lastName: lastName, email: email, phone: phone)
        let contactsModel = ContactListModel(contacts: [contact])
        
        let presenter = defaultPresenter(model: contactsModel)
        let contactRetrieved = presenter.getContactAt(row: 0)

        XCTAssertTrue(contactRetrieved?.id == testId, "Contact retrieved ID is not as expected. Expected: \(testId), retrieved: \(String(describing: contactRetrieved?.id))")
        XCTAssertTrue(contactRetrieved?.firstName == firstName, "Contact retrieved ID is not as expected. Expected: \(firstName), retrieved: \(String(describing: contactRetrieved?.firstName))")
        XCTAssertTrue(contactRetrieved?.lastName == lastName, "Contact retrieved ID is not as expected. Expected: \(lastName), retrieved: \(String(describing: contactRetrieved?.lastName))")
        XCTAssertTrue(contactRetrieved?.email == email, "Contact retrieved ID is not as expected. Expected: \(email), retrieved: \(String(describing: contactRetrieved?.email))")
        XCTAssertTrue(contactRetrieved?.phone == phone, "Contact retrieved ID is not as expected. Expected: \(phone), retrieved: \(String(describing: contactRetrieved?.phone))")
    }

}
