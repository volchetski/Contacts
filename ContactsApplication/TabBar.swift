//
//  TabBar.swift
//  ContactsApplication
//
//  Created by Евгений Волчецкий on 28.02.23.
//

import UIKit

final class TabBar: UITabBarController {
    
    private let contactsController = ContactsController()
    private let favoriteContactsController = FavoriteContactsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVCs()
    }

    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
    public func setupVCs() {
        
        view.backgroundColor = .white
        tabBar.tintColor = .systemBlue
        
        viewControllers = [
            createNavController(for: contactsController, title: NSLocalizedString(Constants.contactsControllerTitle, comment: ""), image: UIImage(systemName: Constants.contactsTabBarImageName)),
            createNavController(for: favoriteContactsController, title: NSLocalizedString(Constants.favoriteContactsControllerTitle, comment: ""), image: UIImage(systemName: Constants.favoriteContactsTabBarImageName))]
    }
}
