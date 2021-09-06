import Foundation

struct ContactListModel {
    var contacts: [Contact]
    
    init (contacts: [Contact] = []) {
        self.contacts = contacts
    }
}
