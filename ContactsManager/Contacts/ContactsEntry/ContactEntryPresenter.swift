//
//  ContactsEntryPresenter.swift
//  ContactsManager
//
//  Created by Sani on 2/9/20.
//  Copyright © 2020 Sani. All rights reserved.
//

import Foundation

protocol ContactEntryPresenterDelegate : NSObjectProtocol {
    func didLoadFields()
}

class ContactEntryPresenter {
    let model : ContactEntryModel
    weak var controllerDelegate: ContactEntryPresenterDelegate?
    
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
}
