import Foundation

class ContactEntryModel {
    var entries: [EntryGroup]
    
    init(fields: [EntryGroup]) {
        self.entries = fields
    }
    
    private func isValid(field: EntryField) -> Bool {
        if field.isRequired  {
            guard let valueString = field.value, !valueString.isEmpty else {
                return false
            }
        }
        return true
    }
    
    func getEntryType(type: EntryFieldType, group: EntryGroupType) -> EntryField? {
        guard let group = entries.first(where: { $0.type == group}) else {
            return nil
        }
        
        guard let field = group.fields.first(where: { $0.type == type }) else {
            return nil
        }
        
        return field
    }
    
    func saveFieldFor(type: EntryFieldType, groupType: EntryGroupType, value: String) -> Bool {
        for groupIndex in 0..<entries.count {
            if (entries[groupIndex].type == groupType) {
                for index in 0..<entries[groupIndex].fields.count {
                    if (entries[groupIndex].fields[index].type == type) {
                        entries[groupIndex].fields[index].value = value
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func checkEntryIsValid(type: EntryFieldType, group: EntryGroupType) -> Bool {
        guard let field = getEntryType(type: type, group: group) else {
            return false
        }
        return isValid(field: field)
    }

    func isValid() -> Bool {
        for entry in entries {
            for field in entry.fields {
                if !isValid(field: field) {
                    return false
                }
            }
        }
        return true
    }
}
