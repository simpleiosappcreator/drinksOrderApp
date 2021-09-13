//
//  Cart.swift
//  DrinksOrderApp
//
//  Created by HAHA on 3/8/2021.
//

import Foundation
import SwiftUI

extension CartWithOrdersView{
    func alert() -> Alert{
        return Alert(
            title: Text("Order confirmation"),
            primaryButton: .cancel(Text("Cancel")),
            secondaryButton: .default(Text("Order"), action: {
                orderVM.showOrderSuccessfullyView.toggle()
                orderVM.sendingDataToDataBase()
                orderVM.orders = []
                orderVM.cartOverallPrice = 0
            }))
    }
}
