import UIKit

class ContactListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let presenter: ContactListPresenter
    
    init(presenter: ContactListPresenter) {
        self.presenter = presenter
        super.init(nibName: "ContactListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ContactListCell", bundle: nil),
                           forCellReuseIdentifier: "contactListCell")
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        tableView.deselectRow(at: selectedIndexPath, animated: true)
    }

}

extension ContactListViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfContacts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "contactListCell", for: indexPath) as! ContactListCell
         
        if let contact = presenter.getContactAt(row: indexPath.row) {
            cell.configureCell(with: contact)
         }
        return cell
    }
}

extension ContactListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let contact = presenter.getContactAt(row: indexPath.row) {
            presenter.contactSelected(contact)
        }
    }
}
