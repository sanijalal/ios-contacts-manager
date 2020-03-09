//
//  ContactsEntryPresenter.swift
//  ContactsManager
//
//  Created by Sani on 2/9/20.
//  Copyright © 2020 Sani. All rights reserved.
//

import Foundation

protocol ContactEntryPresenterDelegate {
    func didPressCancel()
    func didSaveContact(_ contact: Contact)
}

class ContactEntryPresenter {
    let model : ContactEntryModel
    var delegate: ContactEntryPresenterDelegate?
    
    init (model: ContactEntryModel) {
        self.model = model
    }
    
    func groupCount() -> Int {
        return model.entries.count
    }
    
    func rowCountFor(section: Int) -> Int {
        return model.entries[section].fields.count
    }
    
    func titleForGroupAt(index: Int) -> String {
        return model.entries[index].type.rawValue
    }
    
    func model(atPath: IndexPath) -> EntryField? {
        if atPath.section >= model.entries.count {
            return nil
        }
        
        let section = model.entries[atPath.section]
        
        if (atPath.row >= section.fields.count) {
            return nil
        }
        
        return section.fields[atPath.row]
    }
    
    func saveEntryFor(type: EntryFieldType, group:EntryGroupType, value: String) -> Bool {
        return model.saveFieldFor(type: type, groupType: group, value: value)
    }
    
    func validateFields() -> Bool {
        return model.isValid()
    }
    
    func isPathAtLastItem(path: IndexPath) -> Bool {
        if path.section != model.entries.count - 1 {
            return false
        }
        
        let section = model.entries[path.section]
        
        if (path.row != section.fields.count - 1) {
            return false
        }
        return true
    }
    
    func getPathForNextItem(path: IndexPath) -> IndexPath? {
        
        var section = path.section
        var row = path.row
        
        if path.row >= model.entries[path.section].fields.count - 1 {
            // Return next section
            row = 0
            section += 1
        } else {
            row += 1
        }
        
        if section >= model.entries.count {
            return nil // No next path
        }
        
        // Get next row
        return IndexPath(row: row, section: section)
    }
    
    func save(value: String, type: EntryFieldType) {
        _ = model.saveFieldFor(type: type, value: value)
    }
    
    func saveModel() {
        guard let contact = model.currentContact() else {
            return
        }
        
        delegate?.didSaveContact(contact)
    }
    
    func cancelPressed() {
        delegate?.didPressCancel()
    }
    
    func savePressed() {
        
    }
}
