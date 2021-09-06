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
    
    init(presenter: ContactEntryPresenter) {
        self.presenter = presenter
        super.init(nibName: "ContactEntryViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let orangeView = OrangeDotTableHeaderView(frame: CGRect(x: 0, y: 0, width: 320, height: 100))
        tableView.tableHeaderView = orangeView
        
        tableView.register(UINib(nibName: "EntryFieldTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "EntryCell")
        tableView.tableFooterView = UIView(frame: .zero)
        
        setupTopBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset = .zero
        } else {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        tableView.scrollIndicatorInsets = tableView.contentInset
    }

    func setupTopBar() {
        self.navigationItem.setLeftBarButton(UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonItemPressed)),
                                             animated: false)
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonItemPressed)),
        animated: false)
    }
    
    @objc func cancelButtonItemPressed() {
        presenter.cancelPressed()
    }
    
    @objc func saveButtonItemPressed() {
        view.endEditing(true)
        presenter.saveModel()
    }

}

extension ContactEntryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryFieldTableViewCell
        
        if let model = presenter.model(atPath: indexPath) {
            cell.configureCell(field: model,
                               delegate: self,
                               returnKey: presenter.isPathAtLastItem(path: indexPath) ? .go : .next)
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
    
    func pathShouldShowGoButton(path: IndexPath) -> Bool {
        return presenter.isPathAtLastItem(path: path)
    }
}

extension ContactEntryViewController: UITableViewDelegate {

}

extension ContactEntryViewController: EntryFieldTableViewCellDelegate {    
    func entryTypeDidEndEditing(type: EntryFieldType, value: String) {
        presenter.save(value: value, type: type)
    }
    
    func returnPressed(cell: UITableViewCell) {
        guard let currentPath = tableView.indexPath(for: cell) else {
            return
        }
        
        guard let path = presenter.getPathForNextItem(path: currentPath) else {
            presenter.saveModel()
            view.endEditing(true)
            return
        }
        
        if let cell = tableView.cellForRow(at: path) {
            if let entryCell = cell as? EntryFieldTableViewCell {
                entryCell.selectTextField()
                return
            }
        }
    }
}
