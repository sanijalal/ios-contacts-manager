import Foundation

protocol ContactListPresenterDelegate {
    func contactSelected(_ contact: Contact)
}

class ContactListPresenter {
    let contactService : ContactsService
    let model: ContactListModel
    
    var delegate: ContactListPresenterDelegate?
    
    init (contactService: ContactsService) {
        self.contactService = contactService
        self.model = ContactListModel()
    }
    
    func setup () {
        getContacts()
    }
    
    func getContacts () {
        model.contacts = contactService.getContacts()
    }
    
    func numberOfContacts () -> Int {
        return model.contacts.count
    }
    
    func getContactAt(row: Int) -> Contact? {
        if row >= model.contacts.count {
            return nil
        }
        
        return model.contacts[row]
    }
    
    func contactSelected(_ contact: Contact) {
        delegate?.contactSelected(contact)
    }
}
