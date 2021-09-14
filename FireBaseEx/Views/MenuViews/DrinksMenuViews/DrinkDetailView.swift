//
//  DrinkDetailView.swift
//  DrinksOrderApp
//
//  Created by HAHA on 1/8/2021.
//

import SwiftUI

struct DrinkDetailView: View {
    @EnvironmentObject var drinksVM: DrinkViewModel
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var network: NetworkMonitor
    let drinkName: String
    let drinkPrice: Int
    let drinkDescription: String
    let color = Color.theme
    
    @State var amount: Int = 0
    @State var sweetnessSelection: String = "normal"
    let sweetness: [String] = ["less", "normal", "more"]
    @State var toppingsSelection: String = "normal"
    let toppings: [String] = ["less", "normal", "more(+$2)"]
    @State var iceSelection: String = "normal"
    let ice: [String] = ["less", "normal", "more"]
    @State var sizeSelection: String = "normal"
    let size: [String] = ["small", "normal", "large(+$3)"]
    
    @State var isAddedToCart: Bool = false
    @State var showFullImage: Bool = false
    
    @StateObject var drinkImageVM: DrinkImageViewModel
    
    @Namespace var namespace
    
    init(key: String, url: String, name: String, price: Int, description: String){
        _drinkImageVM = StateObject(wrappedValue: DrinkImageViewModel(url: url, key: key))
        self.drinkName = name
        self.drinkPrice = price
        self.drinkDescription = description
    }
    
    var body: some View {
        ZStack {
            color.background.ignoresSafeArea()
            if !network.isConnected{
                NoWifiView()
            }else{
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                    VStack{
                        if drinkImageVM.isLoading{
                            ProgressView()
                        }else if let image = drinkImageVM.image{
                            GeometryReader{geometry in
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: GeometryHelper.getHeightForHeaderImage(geometry: geometry))
                                    .clipped()
                                    .offset(y: GeometryHelper.getOffsetForHeaderImage(geometry: geometry))
                                    .onTapGesture {
                                        showFullImage = true
                                    }
                                    .fullScreenCover(isPresented: $showFullImage, content: {
                                        ShowFullImageSheetView(showFullImage: $showFullImage)
                                    })
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: UIScreen.main.bounds.height * 0.6)
                            .padding(.bottom)
                        }else{
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .padding(.bottom)
                        }
                        
                        VStack{
                            Text(drinkName)
                                .foregroundColor(color.secondary)
                                .font(.title2)
                            Text("($\(drinkPrice))")
                                .foregroundColor(color.secondary)
                                .font(.body)
                        }
                        .padding(.horizontal)
                        
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
                            
                            HStack{
                                Text("Description: \(drinkDescription)")
                                Spacer()
                            }
                            
                            Button(action: {
                                orderVM.addToCart(drinkName: drinkName, drinkAmount: "\(amount)", drinkPrice: "\(drinkPrice)", drinkTotalPrice: orderVM.calculateDrinkTotalPrice(drinkPrice: drinkPrice, drinkAmount: amount, toppingsSelection: toppingsSelection, sizeSelection: sizeSelection), sweetness: sweetnessSelection, toppings: toppingsSelection, ice: iceSelection, size: sizeSelection)
                                amount = 0
                                sweetnessSelection = "normal"
                                toppingsSelection = "normal"
                                iceSelection = "normal"
                                sizeSelection = "normal"
                                isAddedToCart = true
                            }, label: {
                                Text("Add to cart!")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue.cornerRadius(25))
                                    .opacity(checkAmount() ? 1.0 : 0.5)
                            })
                            .padding(.top, 50)
                            .disabled(!checkAmount())
                            .withCustomButtonStyle()
                        }
                        .padding()
                    }
                })
            }
            
            ZStack{
                if isAddedToCart{
                    SaveSuccessfullyToCartView()
                        .transition(.move(edge: .trailing))
                        .animation(.spring())
                        .onAppear(perform: {
                            saveSuccessfullyToCartViewDuration()
                        })
                        .padding()
                }
            }
            .zIndex(1.0)
        }
        .environmentObject(drinkImageVM)
    }
}

struct SaveSuccessfullyToCartView: View{
    var body: some View{
        VStack{
            HStack{
                Spacer()
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue)
                    .frame(width: 100, height: 50)
                    .overlay(
                        Image(systemName: "cart.fill")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 50, height: 50)
                    )
            }
            Spacer()
        }
    }
}

struct DrinkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetailView(key: "", url: "", name: "", price: 1, description: "")
            .preferredColorScheme(.dark)
    }
}
