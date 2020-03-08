import Foundation
import UIKit


class ContactListCoordinator {
    
    let navigationController: UINavigationController
    let contactListPresenter: ContactListPresenter
    var contactEntryPresenter: ContactEntryPresenter?
    
    init () {
        navigationController = UINavigationController()
        contactListPresenter = ContactListPresenter(contactService: ContactsService())
        contactListPresenter.delegate = self
    }
    
    func start () {
        let viewController = ContactListViewController(presenter: contactListPresenter)
        contactListPresenter.setup()
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension ContactListCoordinator: ContactListPresenterDelegate {
    func contactSelected(_ contact: Contact) {
        contactEntryPresenter = nil
        
        let model = ContactEntryModel(fields: [
            EntryGroup(type: .mainInfo, fields: [
                EntryField(type: .firstName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: contact.firstName),
                EntryField(type: .lastName, isRequired: true, keyboardType: .default, capitalizationType: .words, value: contact.lastName),
            ]),
            EntryGroup(type: .subInfo, fields: [
                EntryField(type: .email, isRequired: false, keyboardType: .emailAddress, capitalizationType: .none, value: contact.email),
                EntryField(type: .phoneNumber, isRequired: false, keyboardType: .namePhonePad, capitalizationType: .none, value: contact.phone),
            ])
        ])
        
        contactEntryPresenter = ContactEntryPresenter(model: model)
        guard let presenter = contactEntryPresenter, let visibleViewController = navigationController.visibleViewController else {
            return
        }
        
        let viewController = ContactEntryViewController(presenter: presenter)
        viewController.modalPresentationStyle = .fullScreen
        
        visibleViewController.present(viewController, animated: true) {}
    }
}
