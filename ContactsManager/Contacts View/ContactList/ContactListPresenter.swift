import Foundation

protocol ContactListPresenterDelegate {
    func contactSelected(_ contact: Contact)
}

class ContactListPresenter {
    var model: ContactListModel
    var delegate: ContactListPresenterDelegate?
    var isNeedRefresh: Bool
    
    init (model: ContactListModel) {
        self.model = model
        self.isNeedRefresh = false
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
