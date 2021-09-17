//
//  CartWithOrdersView.swift
//  DrinksOrderApp
//
//  Created by HAHA on 4/8/2021.
//

import SwiftUI

struct CartWithOrdersView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var networkVM: NetworkMonitor
    @State var typeCustomerInfo: Bool = false
    @State var showEidtCustomerInfoSheet: Bool = false
    @State var isCompletedCustomerInfoSheet: Bool = false
    @State var showOrderAlert: Bool = false
    let color = Color.theme
    
    var body: some View {
                VStack{
                    HStack{
                        Spacer()
                        
                        Text("Drink")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(width: 55)
                        Spacer()
                        Text("Quantity")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(width: 100)
                        Spacer()
                        Text("Notes")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(width: 100)
                        Spacer()
                        Text("Price")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(width: 100)
                    }
                    .padding(.top)
                    
                    List{
                        ForEach(orderVM.orders) { order in
                            OrdersDetailInCartView(order: order)
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    HStack{
                        Spacer()
                        
                        HStack{
                            Text("Total price: ")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(color.secondary)
                            Text("$\(orderVM.cartOverallPrice)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(color.secondary)
                        }
                    }
                    .padding()
                    
                    HStack{
                        Button(action: {
                        showEidtCustomerInfoSheet.toggle()
                    }, label: {
                        Text("Customer's information")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 150, height: 75)
                            .background(Color.blue.cornerRadius(25))
                            .padding(.bottom)
                            .multilineTextAlignment(.center)
                    }).sheet(isPresented: $showEidtCustomerInfoSheet, content: {
                        EditCustomerInfoView(isCompletedCustomerInfoSheet: $isCompletedCustomerInfoSheet).environmentObject(self.orderVM).environmentObject(self.networkVM)
                    })
                        
                        Button(action: {
                            showOrderAlert.toggle()
                        }, label: {
                            Text("Order!")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 150, height: 75)
                                .background(Color.blue.cornerRadius(25))
                                .opacity(orderVM.checkAtleastOneDrinkInCart() && isCompletedCustomerInfoSheet && networkVM.isConnected ? 1.0 : 0.5)
                                .padding(.bottom)
                        })
                        .alert(isPresented: $showOrderAlert, content: {
                            alert()
                        })
                        .disabled(!(orderVM.checkAtleastOneDrinkInCart() && isCompletedCustomerInfoSheet && networkVM.isConnected))
                    }
                }
                
                ZStack{
                    if orderVM.showOrderSuccessfullyView{
                        SaveSuccessfullyOrderView()
                            .transition(.move(edge: .trailing))
                            .animation(.spring())
                            .onAppear(perform: {
                                orderVM.saveSuccessfullyOrderViewDuration()
                            })
                            .padding()
                    }
                }
            }
    }


struct CartWithOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        CartWithOrdersView()
    }
}
