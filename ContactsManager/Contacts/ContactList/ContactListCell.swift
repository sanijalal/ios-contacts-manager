//
//  ContactListCell.swift
//  ContactsManager
//
//  Created by Sani on 3/7/20.
//  Copyright © 2020 Sani. All rights reserved.
//

import UIKit

class ContactListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with contact: Contact) {
        nameLabel.text = contact.firstName + " " + contact.lastName
    }
}
