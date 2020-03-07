import Foundation
import UIKit

class ContactListCoordinator {
    
    let navigationController: UINavigationController
    let contactListPresenter: ContactListPresenter
    
    init () {
        navigationController = UINavigationController()
        contactListPresenter = ContactListPresenter(contactService: ContactsService())
    }
    
    func start () {
        let viewController = ContactListViewController(presenter: contactListPresenter)
        contactListPresenter.setup()
        navigationController.pushViewController(viewController, animated: false)
    }
}
