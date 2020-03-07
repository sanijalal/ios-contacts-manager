import Foundation

class ContactsService {
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func getDocumentsFilePath(fileName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(fileName)
    }
    
    private func storedFileLocation(fileName: String) -> URL? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        
        return url.appendingPathComponent(fileName)
    }
    
    private func getContactsFromBundle() -> [Contact] {
        guard let fileUrl = Bundle.main.url(forResource: "data", withExtension: "json") else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            let contacts = try JSONDecoder().decode([Contact].self, from: data)
            return contacts
        } catch {
            return []
        }
    }
    
    private func getContactsFromDocuments() -> [Contact]? {
        guard let fileUrl = storedFileLocation(fileName: "contacts") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            let contacts = try JSONDecoder().decode([Contact].self, from: data)
            return contacts
        } catch {
            return nil
        }
    }
    
    func getContacts() -> [Contact] {        
        guard let contacts = getContactsFromDocuments() else {
            return getContactsFromBundle()
        }

        return contacts
    }
    
    func save(contacts: [Contact]) -> Bool {
        do {
            let contactData = try JSONEncoder().encode(contacts)
            let fileUrl = getDocumentsFilePath(fileName: "contacts")
            try contactData.write(to: fileUrl)
            return true
        } catch {
            
        }
        return false
    }
}
