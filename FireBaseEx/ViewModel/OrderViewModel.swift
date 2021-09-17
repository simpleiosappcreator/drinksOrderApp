//
//  OrderViewModel.swift
//  DrinksOrderApp
//
//  Created by HAHA on 2/8/2021.
//

import Foundation
import Firebase
import SwiftUI

class OrderViewModel: ObservableObject{
    @Published var orders: [Order] = []
    @Published var cartOverallPrice: Int = 0
    @Published var customerName: String = ""
    @Published var customerPhoneNumber: String = ""
    @Published var deliveryLocation: String = ""
    @Published var showOrderSuccessfullyView: Bool = false
    @Published var showSlideMenu: Bool = false
    
    func addToCart(drinkName: String, drinkAmount: String, drinkPrice: String, drinkTotalPrice: Int, sweetness: String, toppings: String, ice: String, size: String){
        let newOrder = Order(drinkName: drinkName, drinkAmount: drinkAmount, drinkPrice: drinkPrice, drinkTotalPrice: "\(drinkTotalPrice)", sweetness: sweetness, toppings: toppings, ice: ice, size: size, customerName: customerName, customerPhoneNumber: customerPhoneNumber, deliveryLocation: deliveryLocation)
        self.orders.append(newOrder)
        
        self.cartOverallPrice += drinkTotalPrice
    }
    
    func calculateDrinkTotalPrice(drinkPrice: Int, drinkAmount: Int, toppingsSelection: String, sizeSelection: String) -> Int{
        var eachTotalPrice = drinkPrice
        eachTotalPrice += toppingsSelection == "more(+$2)" ? 2 : 0
        eachTotalPrice += sizeSelection == "large(+$3)" ? 3 : 0
        eachTotalPrice *= drinkAmount
        return eachTotalPrice
    }
    
    func checkAtleastOneDrinkInCart() -> Bool{
        return !orders.isEmpty ? true : false
    }
    
    func deleteItemInCart(model: Order){
        guard let index = orders.firstIndex(where: {$0.id == model.id}) else{return}
        self.cartOverallPrice -= Int(orders[index].drinkTotalPrice) ?? 0
        orders.remove(at: index)
    }
    
    func sendingDataToDataBase(){
        let db = Firestore.firestore()
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        for i in 0..<orders.count{
            db.collection("orders").document("\(year)-\(month)-\(day)-\(hour):\(minute):\(second)(\(orders[i].id))").setData(["Drink name" : orders[i].drinkName, "Drink amount" : orders[i].drinkAmount, "Drink price" : orders[i].drinkPrice, "Drink total price" : orders[i].drinkTotalPrice, "Sweetness" : orders[i].sweetness, "Toppings" : orders[i].toppings, "Ice" : orders[i].ice, "Size" : orders[i].size, "Customer name" : orders[i].customerName, "Customer phone number" : orders[i].customerPhoneNumber, "Delivery location" : orders[i].deliveryLocation])
        }
    }
    
    func saveSuccessfullyOrderViewDuration(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.showOrderSuccessfullyView = false
        }
    }
    
    func editCustomerInfo(name: String, phoneNumber: String, location: String){
        self.customerName = name
        self.customerPhoneNumber = phoneNumber
        self.deliveryLocation = location
        
        for i in 0..<orders.count{
            let tempOrder = Order(drinkName: orders[i].drinkName, drinkAmount: orders[i].drinkAmount, drinkPrice: orders[i].drinkPrice, drinkTotalPrice: orders[i].drinkTotalPrice, sweetness: orders[i].sweetness, toppings: orders[i].toppings, ice: orders[i].ice, size: orders[i].size, customerName: name, customerPhoneNumber: phoneNumber, deliveryLocation: location)
            
            orders[i] = tempOrder
        }
    }
    
    func checkCustomerInfo(name: String, phoneNumber: String, location: String) -> Bool{
        return name.count > 3 && phoneNumber.count > 3 && location.count > 3 ? true : false
    }
    
    func editItem(drinkName: String, drinkAmount: String, drinkPrice: String, drinkTotalPrice: Int, sweetness: String, toppings: String, ice: String, size: String, model: Order){
        
        self.cartOverallPrice -= Int(model.drinkTotalPrice) ?? 0
        
        guard let index  = orders.firstIndex(where: {$0.id == model.id}) else{return}
        
        let newOrder = Order(drinkName: drinkName, drinkAmount: drinkAmount, drinkPrice: drinkPrice, drinkTotalPrice: "\(drinkTotalPrice)", sweetness: sweetness, toppings: toppings, ice: ice, size: size, customerName: customerName, customerPhoneNumber: customerPhoneNumber, deliveryLocation: deliveryLocation)
        
        self.orders[index] = newOrder
        
        self.cartOverallPrice += drinkTotalPrice
    }
}
