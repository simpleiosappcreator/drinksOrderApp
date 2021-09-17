//
//  Order.swift
//  DrinksOrderApp
//
//  Created by HAHA on 1/8/2021.
//

import Foundation
struct Order: Identifiable, Codable{
    let id: String
    let drinkName: String
    let drinkAmount: String
    let drinkPrice: String
    let drinkTotalPrice: String
    let sweetness: String
    let toppings: String
    let ice: String
    let size: String
    let customerName: String
    let customerPhoneNumber: String
    let deliveryLocation: String
    
    init(id: String = UUID().uuidString, drinkName: String, drinkAmount: String, drinkPrice: String, drinkTotalPrice: String, sweetness: String, toppings: String, ice: String, size: String, customerName: String, customerPhoneNumber: String, deliveryLocation: String){
        self.id = id
        self.drinkName = drinkName
        self.drinkAmount = drinkAmount
        self.drinkPrice = drinkPrice
        self.drinkTotalPrice = drinkTotalPrice
        self.sweetness = sweetness
        self.toppings = toppings
        self.ice = ice
        self.size = size
        self.customerName = customerName
        self.customerPhoneNumber = customerPhoneNumber
        self.deliveryLocation = deliveryLocation
    }
}
