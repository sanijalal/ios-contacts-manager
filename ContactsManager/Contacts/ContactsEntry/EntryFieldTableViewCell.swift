//
//  EntryFieldTableViewCell.swift
//  ContactsManager
//
//  Created by Sani on 2/8/20.
//  Copyright © 2020 Sani. All rights reserved.
//

import UIKit

protocol EntryFieldTableViewCellDelegate :NSObjectProtocol {
    func returnPressed(cell: UITableViewCell)
    func entryTypeDidEndEditing(type: EntryFieldType, value: String)
}

class EntryFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var fieldLabel: UILabel!
    private weak var entryFieldDelegate: EntryFieldTableViewCellDelegate?
    
    private var isShowingRequired: Bool!
    private var isRequiredCell: Bool!
    var entryType: EntryFieldType?
    
    required init?(coder: NSCoder) {
        self.isShowingRequired = false
        self.isRequiredCell = false
        super.init(coder: coder)
        self.selectionStyle = .none
    }
    
    func configureCell(field: EntryField, delegate: EntryFieldTableViewCellDelegate, returnKey: UIReturnKeyType) {
        fieldLabel.text = field.type.rawValue
        textField.text = field.value
        isRequiredCell = field.isRequired
        entryType = field.type
        entryFieldDelegate = delegate
        
        textField.keyboardType = field.keyboardType
        textField.returnKeyType = returnKey
    }
    
    func showRequired () {
        textField.layer.shadowColor = CGColor.init(srgbRed: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        textField.layer.shadowOffset = CGSize(width: 0, height: 0)
        textField.layer.shadowOpacity = 1.0
        isShowingRequired = true
    }
    
    func showOk () {
        textField.layer.shadowOpacity = 0.0
        isShowingRequired = false
    }
    
    func toggleShowRequired () {
        if isRequiredCell {
            return
        }
        
        if isShowingRequired {
            showOk()
        } else {
            showRequired()
        }
    }
    
    func selectTextField () {
        textField.becomeFirstResponder()
    }
}

extension EntryFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ thisTextField: UITextField) {
        guard let text = thisTextField.text, let type = entryType else {
            return
        }
        entryFieldDelegate?.entryTypeDidEndEditing(type: type, value: text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        entryFieldDelegate?.returnPressed(cell: self)
        return true
    }
}
