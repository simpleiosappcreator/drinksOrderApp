//
//  DrinkDetail.swift
//  DrinksOrderApp
//
//  Created by HAHA on 2/8/2021.
//

import Foundation
extension DrinkDetailView{
    func addAmount(){
        amount = amount >= 0 ? amount + 1 : 0
    }
    
    func reduceAmount(){
        amount = amount > 0 ? amount - 1 : 0
    }
    
    func checkAmount() -> Bool{
        return amount > 0 ? true : false
    }
    
    func saveSuccessfullyToCartViewDuration(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isAddedToCart = false
        }
    }
}
