//
//  Drink.swift
//  DrinksOrderApp
//
//  Created by HAHA on 1/8/2021.
//

import Foundation
struct Drink: Identifiable, Codable{
    let id: Int
    let name: String
    let price: Int
    let availableStatus: String
    let description: String
    let imageUrl: String
    
    init(id: Int, name: String, price: Int, availableStatus: String, description: String, imageUrl: String){
        self.id = id
        self.name = name
        self.price = price
        self.availableStatus = availableStatus
        self.description = description
        self.imageUrl = imageUrl
    }
}
