//
//  ContactTableViewCell.swift
//  ContactsApplication
//
//  Created by Евгений Волчецкий on 28.02.23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    public let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let givenNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let familyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .label
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private let addFavoriteContactButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemRed
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var link = ContactsController()
    
    public var contact: Contact? {
        didSet {
            guard let contactItem = contact else { return }
            givenNameLabel.text = contactItem.givenName
            familyNameLabel.text = contactItem.familyName
            phoneNumberLabel.text = contactItem.numberPhone
            profileImageView.image = contactItem.hasContactImage ? UIImage(data: link.imageContact) : UIImage(systemName: Constants.contactsTabBarImageName)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        addConstraints()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.contentView.addSubview(profileImageView)
        containerView.addSubview(givenNameLabel)
        containerView.addSubview(familyNameLabel)
        containerView.addSubview(phoneNumberLabel)
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(addFavoriteContactButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: contentView.frame.height),
            profileImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height),
        
            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.heightAnchor.constraint(equalToConstant: 40),
        
            givenNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            givenNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            givenNameLabel.trailingAnchor.constraint(equalTo: familyNameLabel.leadingAnchor, constant: -5),
        
            phoneNumberLabel.topAnchor.constraint(equalTo: givenNameLabel.bottomAnchor),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
        
            addFavoriteContactButton.widthAnchor.constraint(equalToConstant: contentView.frame.height),
            addFavoriteContactButton.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            addFavoriteContactButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            addFavoriteContactButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
