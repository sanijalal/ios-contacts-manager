import Foundation
import UIKit


class ContactListCoordinator {
    
    let navigationController: UINavigationController
    let contactListPresenter: ContactListPresenter
    let contactService: ContactsService
    var contactEntryPresenter: ContactEntryPresenter?
    
    var contacts: [Contact]
    
    init () {
        navigationController = UINavigationController()
        contactService = ContactsService()
        contacts = []
        
        let model = ContactListModel()
        contactListPresenter = ContactListPresenter(model: model)
        contactListPresenter.delegate = self
    }
    
    func start () {
        let viewController = ContactListViewController(presenter: contactListPresenter)
        contacts = contactService.getContacts()
        contactListPresenter.model.contacts = contacts
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
        ], id: contact.id)
        
        contactEntryPresenter = ContactEntryPresenter(model: model)
        guard let presenter = contactEntryPresenter, let visibleViewController = navigationController.visibleViewController else {
            return
        }
        
        let viewController = ContactEntryViewController(presenter: presenter)
        presenter.delegate = self
        
        let presentedNavigationController = UINavigationController()
        presentedNavigationController.pushViewController(viewController, animated: false)
        presentedNavigationController.modalPresentationStyle = .fullScreen
        
        visibleViewController.present(presentedNavigationController, animated: true) {}
    }
}

extension ContactListCoordinator: ContactEntryPresenterDelegate {
    func didSaveContact(_ contact: Contact) {
        if contactService.saveContact(contact, contacts: contacts) {
            contactListPresenter.isNeedRefresh = true
            contacts = contactService.getContacts()
            contactListPresenter.model.contacts = contacts
        }
        
        guard let presentedController = navigationController.presentedViewController else {
            return
        }
        
        presentedController.dismiss(animated: true) {}
    }
    
    func didPressCancel() {
        guard let presentedController = navigationController.presentedViewController else {
            return
        }
        
        presentedController.dismiss(animated: true) {}
    }
}
