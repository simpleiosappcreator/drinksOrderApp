//
//  OrdersDetailInCartView.swift
//  FireBaseEx
//
//  Created by HAHA on 6/9/2021.
//

import SwiftUI

struct OrdersDetailInCartView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    let order: Order
    @State var deleteItemAlert: Bool = false
    @State var showEditView: Bool = false
    
    var body: some View {
        HStack{
            Spacer()
            Text("\(order.drinkName)($\(order.drinkPrice))")
                .font(.system(size: 13))
                .frame(width: 55)
                .multilineTextAlignment(.leading)
            Spacer()
            
            Text("X\(order.drinkAmount)")
                .frame(width: 100)
            
            Spacer()
            
            VStack(alignment: .leading){
                Text("sweetness: \(order.sweetness)")
                    .font(.system(size: 13))
                    .multilineTextAlignment(.leading)
                Text("toppings: \(order.toppings)")
                    .font(.system(size: 13))
                    .multilineTextAlignment(.leading)
                Text("ice: \(order.ice)")
                    .font(.system(size: 13))
                    .multilineTextAlignment(.leading)
                Text("size: \(order.size)")
                    .font(.system(size: 13))
                    .multilineTextAlignment(.leading)
            }
            .frame(width: 100)
            
            Spacer()
            
            Text("$\(order.drinkTotalPrice)")
                .frame(width: 100)
        }
        .contextMenu {
            Button {
                showEditView.toggle()
            } label: {
                Label {
                    Text("Edit")
                } icon: {
                    Image(systemName: "bubble.left")
                }
            }
            
            Button {
                deleteItemAlert = true
            } label: {
                Label {
                    Text("Delete")
                        .foregroundColor(.red)
                } icon: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .alert(isPresented: $deleteItemAlert) {
            Alert(title: Text("Delete this item?"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete"), action: {
                orderVM.deleteItemInCart(model: order)
            }))
        }
        .sheet(isPresented: $showEditView) {
            EditItemView(model: order)
        }
    }
}

struct OrdersDetailInCartView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersDetailInCartView(order: Order(drinkName: "", drinkAmount: "", drinkPrice: "", drinkTotalPrice: "", sweetness: "", toppings: "", ice: "", size: "", customerName: "", customerPhoneNumber: "", deliveryLocation: ""))
    }
}
