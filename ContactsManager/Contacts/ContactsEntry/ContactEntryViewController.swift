//
//  ContactEntryViewController.swift
//  ContactsManager
//
//  Created by Sani on 2/8/20.
//  Copyright © 2020 Sani. All rights reserved.
//

import UIKit

class ContactEntryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let presenter: ContactEntryPresenter!
    
    convenience init() {
        self.init(presenter: ContactEntryPresenter(model: ContactEntryModel(fields: [
            EntryGroup(type: .mainInfo, fields: [
                EntryField(type: .firstName, isRequired: true, value: ""),
                EntryField(type: .lastName, isRequired: true, value: ""),
            ]),
            EntryGroup(type: .subInfo, fields: [
                EntryField(type: .email, isRequired: false, value: ""),
                EntryField(type: .phoneNumber, isRequired: false, value: ""),
            ])
        ])))
    }
    
    init(presenter: ContactEntryPresenter) {
        self.presenter = presenter
        super.init(nibName: "ContactEntryViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "EntryFieldTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "EntryCell")
        tableView.tableFooterView = UIView(frame: .zero)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ContactEntryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryFieldTableViewCell
        
        if let model = presenter.model(atPath: indexPath) {
            cell.configureCell(field: model)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.groupCount()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.titleForGroupAt(index: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rowCountFor(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ContactEntryViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! EntryFieldTableViewCell
//        self.isShowingRequired = false
//    }
}
