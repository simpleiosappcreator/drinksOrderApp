//
//  MenuItemModel.swift
//  SlideMenu
//
//  Created by HAHA on 16/8/2021.
//

import Foundation

struct MenuItemModel: Identifiable{
    var id = UUID().uuidString
    let image: String
    let title: String
}
