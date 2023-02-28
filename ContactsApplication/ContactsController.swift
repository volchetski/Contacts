//
//  ContactsController.swift
//  ContactsApplication
//
//  Created by Евгений Волчецкий on 28.02.23.
//

import UIKit
import Contacts

class ContactsController: UIViewController {
    
    private let addContactsButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.addContactsButtonTitle, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 23)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var contactsTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: Constants.contactTableViewId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
//    public let contacts = ContactAPI.getContacts()
    public var contactStore = CNContactStore()
    public var contacts = [Contact]()
    public var imageContact: Data?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addConstraints()
        
        
        contactStore.requestAccess(for: .contacts) { success, error in
            if success {
                print("authoriztaion successful")
            }
        }
        fetchContacts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupVCs()
    }
    
    func fetchContacts() {
        
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataAvailableKey, CNContactImageDataKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        try? contactStore.enumerateContacts(with: request) { contact, stoppingPointer in
            let name = contact.givenName
            let familyName = contact.familyName
            let hasImage = contact.imageDataAvailable
            guard let number = contact.phoneNumbers.first?.value.stringValue else { return }
            imageContact = contact.imageData
            
            
            let contactToAppend = Contact(givenName: name, familyName: familyName, numberPhone: number, hasContactImage: hasImage)
            
            contacts.append(contactToAppend)
        }
       
    }
    
    private func setupVCs() {
        
        addContactsButton.layer.cornerRadius = addContactsButton.frame.height / 2.5
    }
    
    private func addSubviews() {
        view.addSubview(addContactsButton)
        view.addSubview(contactsTableView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            addContactsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addContactsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            addContactsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55),
            addContactsButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            contactsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contactsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contactsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contactsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
