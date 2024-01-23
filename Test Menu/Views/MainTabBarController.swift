//
//  MainTabBarController.swift
//  Test Menu
//
//  Created by Sergey Savinkov on 17.01.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupItems()
        setupNavigationBar()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .black
        tabBar.tintColor = .yellow
        tabBar.unselectedItemTintColor = .white
        tabBar.layer.borderColor = UIColor.black.cgColor
    }
    
    private func setupItems() {
        let menuVC = ViewController()
        let contactVC = ViewController()
        let profileVC = ViewController()
        
        setViewControllers([menuVC, contactVC, profileVC],
                           animated: true)
        
        guard let items = tabBar.items else { return }
        
        items[0].image = UIImage(systemName: "list.bullet")
        items[1].image = UIImage(systemName: "bag")
        items[2].image = UIImage(systemName: "info")
    }
    
    private func setupNavigationBar() {
        navigationItem.titleView = createCustomTitle()
    }
    
    private func createCustomTitle() -> UIView {
        let view = UIView()
        
        let heightNavBar = navigationController?.navigationBar.frame.height ?? 0
        let widthNavBar = navigationController?.navigationBar.frame.width ?? 0
        
        view.frame = CGRect(x: 0, y: 0, width: widthNavBar, height: heightNavBar)
        
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .left
        logoImageView.frame = CGRect(x: -170, y: 0, width: widthNavBar, height: heightNavBar)
        
        view.addSubview(logoImageView)
        
        return view
    }
}
