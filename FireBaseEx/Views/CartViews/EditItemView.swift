//
//  EditItemView.swift
//  FireBaseEx
//
//  Created by HAHA on 6/9/2021.
//

import SwiftUI

struct EditItemView: View {
    let model: Order
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(model: Order(drinkName: "", drinkAmount: "", drinkPrice: "", drinkTotalPrice: "", sweetness: "", toppings: "", ice: "", size: "", customerName: "", customerPhoneNumber: "", deliveryLocation: ""))
    }
}
