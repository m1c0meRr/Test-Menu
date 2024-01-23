//
//  MenuModel.swift
//  Test Menu
//
//  Created by Sergey Savinkov on 17.01.2024.
//

import Foundation

struct MenuModel: Codable {
    let status: Bool
    let menuList: [MenuModelListItem]
}

struct MenuModelListItem: Codable {
    let id: String
    let image: String
    let name: String
    let content: String
    let price: String
    let weight: String
    let spicy: String?
}
