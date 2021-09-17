//
//  EditItemView.swift
//  FireBaseEx
//
//  Created by HAHA on 6/9/2021.
//

import SwiftUI

struct EditItemView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var network: NetworkMonitor
    @Environment (\.presentationMode) var presentationMode
    let model: Order
    let color = Color.theme
    
    @State var amount: Int = 0
    @State var sweetnessSelection: String = ""
    let sweetness: [String] = ["less", "normal", "more"]
    @State var toppingsSelection: String = ""
    let toppings: [String] = ["less", "normal", "more(+$2)"]
    @State var iceSelection: String = ""
    let ice: [String] = ["less", "normal", "more"]
    @State var sizeSelection: String = ""
    let size: [String] = ["small", "normal", "large(+$3)"]
    
    var body: some View {
        ZStack{
            color.background
            if !network.isConnected{
                NoWifiView()
            }else{
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack{
                        
                        VStack{
                            Text(model.drinkName)
                                .foregroundColor(color.secondary)
                                .font(.title2)
                            Text("($\(model.drinkPrice))")
                                .foregroundColor(color.secondary)
                                .font(.body)
                        }
                        .padding()
                        
                        VStack(spacing: 15){
                            Stepper("Number of drinks: \(amount)") {
                                addAmount()
                            } onDecrement: {
                                reduceAmount()
                            }
                            
                            HStack{
                                Text("Sweetness")
                                
                                Spacer(minLength: 30)
                                
                                Picker(selection: $sweetnessSelection,
                                       label: Text("Sweetness"),
                                       content: {
                                        ForEach(sweetness, id: \.self) { option in
                                            Text(option)
                                                .tag(option)
                                        }
                                })
                                    .pickerStyle(SegmentedPickerStyle())
                            }
                            
                            HStack{
                                Text("toppings")
                                
                                Spacer(minLength: 45)
                                
                                Picker(selection: $toppingsSelection,
                                       label: Text("toppings"),
                                       content: {
                                        ForEach(toppings, id: \.self) { option in
                                            Text(option)
                                                .tag(option)
                                        }
                                })
                                    .pickerStyle(SegmentedPickerStyle())
                            }
                            
                            HStack{
                                Text("ice")
                                
                                Spacer(minLength: 90)
                                
                                Picker(selection: $iceSelection,
                                       label: Text("ice"),
                                       content: {
                                        ForEach(ice, id: \.self) { option in
                                            Text(option)
                                                .tag(option)
                                        }
                                })
                                    .pickerStyle(SegmentedPickerStyle())
                            }
                            
                            HStack{
                                Text("size")
                                
                                Spacer(minLength: 82)
                                
                                Picker(selection: $sizeSelection,
                                       label: Text("size"),
                                       content: {
                                        ForEach(size, id: \.self) { option in
                                            Text(option)
                                                .fontWeight(.semibold)
                                                .tag(option)
                                        }
                                })
                                    .pickerStyle(SegmentedPickerStyle())
                            }
                            
                            Button(action: {
                                orderVM.editItem(drinkName: model.drinkName, drinkAmount: "\(amount)", drinkPrice: model.drinkPrice, drinkTotalPrice: orderVM.calculateDrinkTotalPrice(drinkPrice: Int(model.drinkPrice) ?? 0, drinkAmount: amount, toppingsSelection: toppingsSelection, sizeSelection: sizeSelection), sweetness: sweetnessSelection, toppings: toppingsSelection, ice: iceSelection, size: sizeSelection, model: model)
                                amount = 0
                                sweetnessSelection = "normal"
                                toppingsSelection = "normal"
                                iceSelection = "normal"
                                sizeSelection = "normal"
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Text("Finish")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue.cornerRadius(25))
                            })
                            .padding(.top, 50)
                            .withCustomButtonStyle()
                        }
                        .padding()
                    }
                })
            }
        }
        .onAppear{
            amount = Int(model.drinkAmount) ?? 0
            sweetnessSelection = model.sweetness
            toppingsSelection = model.toppings
            iceSelection = model.ice
            sizeSelection = model.size
        }
    }
    
    func addAmount(){
        amount += 1
    }
    
    func reduceAmount(){
        amount = amount > 1 ? amount - 1 : amount
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(model: Order(drinkName: "", drinkAmount: "", drinkPrice: "", drinkTotalPrice: "", sweetness: "", toppings: "", ice: "", size: "", customerName: "", customerPhoneNumber: "", deliveryLocation: ""))
    }
}
