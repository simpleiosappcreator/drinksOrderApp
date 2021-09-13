//
//  DrinkNavigationLinkView.swift
//  DrinksOrderApp
//
//  Created by HAHA on 1/8/2021.
//

import SwiftUI

struct DrinkNavigationLinkView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    let drink: Drink
    let color = Color.theme
    
    var body: some View {
        if orderVM.showSlideMenu{
            if drink.availableStatus == "(售罄)"{
                DrinkNavigationLinkLabelView(key: "\(drink.id)", url: drink.imageUrl, name: drink.name, status: drink.availableStatus)
                    .opacity(0.5)
            }else{
                DrinkNavigationLinkLabelView(key: "\(drink.id)", url: drink.imageUrl, name: drink.name, status: drink.availableStatus)
            }
        }else{
            if drink.availableStatus == "(售罄)"{
                DrinkNavigationLinkLabelView(key: "\(drink.id)", url: drink.imageUrl, name: drink.name, status: drink.availableStatus)
                    .opacity(0.5)
            }else{
                NavigationLink(
                    destination: DrinkDetailView(key: "\(drink.id)", url: drink.imageUrl, name: drink.name, price: drink.price, description: drink.description),
                    label: {
                        DrinkNavigationLinkLabelView(key: "\(drink.id)", url: drink.imageUrl, name: drink.name, status: drink.availableStatus)
                    })
            }
        }
    }
}

struct DrinkNavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkNavigationLinkView(drink: Drink(id: 1, name: "", price: 1, availableStatus: "", description: "", imageUrl: ""))
    }
}
