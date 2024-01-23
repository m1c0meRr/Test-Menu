//
//  CategoryModel.swift
//  Test Menu
//
//  Created by Sergey Savinkov on 17.01.2024.
//

import Foundation

struct CategoryModel: Codable {
    let status: Bool
    let menuList: [MenuListItem]
}

struct MenuListItem: Codable {
    let menuID: String
    let image: String
    let name: String
    let subMenuCount: Int
}
