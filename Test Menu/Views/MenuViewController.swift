//
//  MenuViewController.swift
//  Test Menu
//
//  Created by Sergey Savinkov on 17.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let collectionViewMenu: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let collectionViewCategory: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var menuArray = [MenuModelListItem]()
    private var menuArray1 = [MenuModel]()
    private var categoryArray = [MenuListItem]()
    private var categoryArray1 = [CategoryModel]()
    var menuID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCategory()
        setupView()
        setupDelegate()
        setConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.1568627059, green: 0.1568627059, blue: 0.1568627059, alpha: 1)
        
        collectionViewMenu.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCellID")
        collectionViewCategory.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCellID")
        
        view.addSubview(collectionViewMenu)
        view.addSubview(headerLabel)
        view.addSubview(collectionViewCategory)
    }
    
    private func setupDelegate() {
        collectionViewMenu.delegate = self
        collectionViewMenu.dataSource = self
        
        collectionViewCategory.delegate = self
        collectionViewCategory.dataSource = self
    }
    
    func setupCategory() {
        
        guard let url = URL(string: "https://vkus-sovet.ru/api/getMenu.php") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data {
                do {
                    let decodeResponce = try JSONDecoder().decode(CategoryModel.self, from: data)
                    DispatchQueue.main.async {
                        print(decodeResponce)
                        self.categoryArray = decodeResponce.menuList
                        self.collectionViewCategory.reloadData()
                    }
                } catch {
                    print("error:", error)
                }
                return
            }
        }.resume()
    }
    
    func setupCategoryMenu(id: String) {
        
        guard let url = URL(string: "https://vkus-sovet.ru/api/getSubMenu.php?menuID=" + "\(id)") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data {
                do {
                    let decodeResponce = try JSONDecoder().decode(MenuModel.self, from: data)
                    DispatchQueue.main.async {
                        print(decodeResponce)
                        self.menuArray = decodeResponce.menuList
                        self.collectionViewMenu.reloadData()
                    }
                } catch {
                    print("error:", error)
                }
                return
            }
        }.resume()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            collectionViewCategory.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionViewCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionViewCategory.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionViewCategory.heightAnchor.constraint(equalToConstant: 150),
            
            headerLabel.topAnchor.constraint(equalTo: collectionViewCategory.bottomAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerLabel.heightAnchor.constraint(equalToConstant: 50),
            
            collectionViewMenu.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            collectionViewMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionViewMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionViewMenu.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - UITableViewDelegate

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewCategory {
            let model = categoryArray[indexPath.row]
            setupCategoryMenu(id: model.menuID)
            headerLabel.text = model.name
            collectionViewMenu.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewCategory {
            return categoryArray.count
        } else if  collectionView == self.collectionViewMenu {
            return menuArray.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionViewCategory {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCellID", for: indexPath) as! CategoryCollectionViewCell
            
            let model = categoryArray[indexPath.row]
            cellA.cellConfigure(model: model)
            cellA.layer.cornerRadius = 10
            
            return cellA
        } else {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCellID", for: indexPath) as! MenuCollectionViewCell
            
            let model = menuArray[indexPath.row]
            cellB.cellConfigure(model: model)
            cellB.layer.cornerRadius = 10
            
            return cellB
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionViewCategory {
            CGSize(width: 110,
                   height: 150)
        } else {
            CGSize(width: 165,
                   height: 230)
        }
    }
}



