//
//  ContactsController + Ex.swift
//  ContactsApplication
//
//  Created by Евгений Волчецкий on 28.02.23.
//

import UIKit

extension ContactsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.contactTableViewId, for: indexPath) as? ContactTableViewCell else { fatalError("FatalError from cell") }
                
        cell.contact = contacts[indexPath.row]
        return cell
    }
}
