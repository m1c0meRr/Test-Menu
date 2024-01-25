//
//  MenuCollectionViewCell.swift
//  Test Menu
//
//  Created by Sergey Savinkov on 17.01.2024.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Name"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "decr"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Price"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "weight"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("В корзину", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    static let collectionViewCellID = "collectionViewCellID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        backgroundColor = .black
        
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(weightLabel)
        addSubview(cellImageView)
        addSubview(button)
    }
    
    func cellConfigure(model: MenuModelListItem) {
        nameLabel.text = model.name
        descriptionLabel.text = model.content
        priceLabel.text = model.price + " Р"
        weightLabel.text = "/ " + model.weight
        
        let urlString = "https://vkus-sovet.ru" + model.image
        let url = URL(string: urlString)!
        
        ServiceManager.shared.requestImage(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let data):
                let image = UIImage(data: data)
                self.cellImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            priceLabel.topAnchor.constraint(equalTo: cellImageView.topAnchor, constant: -20),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            
            weightLabel.topAnchor.constraint(equalTo: cellImageView.topAnchor, constant: -19),
            weightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            weightLabel.leadingAnchor.constraint(equalTo: centerXAnchor),
            
            cellImageView.topAnchor.constraint(equalTo: centerYAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            button.topAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 55),
            button.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
