//
//  EntryFieldTableViewCell.swift
//  ContactsManager
//
//  Created by Sani on 2/8/20.
//  Copyright © 2020 Sani. All rights reserved.
//

import UIKit

class EntryFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var fieldLabel: UILabel!
    private var isShowingRequired: Bool!
    private var isRequiredCell: Bool!

    required init?(coder: NSCoder) {
        self.isShowingRequired = false
        self.isRequiredCell = false
        super.init(coder: coder)
        self.selectionStyle = .none
    }
    
    func configureCell(field: EntryField) {
        fieldLabel.text = field.type.rawValue
        textField.text = field.value
        isRequiredCell = field.isRequired
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
}
