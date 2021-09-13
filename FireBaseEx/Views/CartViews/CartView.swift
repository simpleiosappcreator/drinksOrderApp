//
//  CartView.swift
//  DrinksOrderApp
//
//  Created by HAHA on 1/8/2021.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var network: NetworkMonitor
    let color = Color.theme
    @State var showOrderSuccessfullyView: Bool = false
    var body: some View {
        ZStack{
            color.background.ignoresSafeArea()
            VStack{
                if !orderVM.orders.isEmpty{
                    CartWithOrdersView()
                }else{
                    Text("Add some items! 🥳")
                        .font(.title)
                        .fontWeight(.semibold)
                }
            }
            
            if orderVM.showOrderSuccessfullyView{
                ZStack{
                    SaveSuccessfullyOrderView()
                        .transition(.move(edge: .trailing))
                        .animation(.spring())
                        .onAppear(perform: {
                            orderVM.saveSuccessfullyOrderViewDuration()
                        })
                        .padding()
                }
                .zIndex(1.0)
            }
        }
    }
}

struct SaveSuccessfullyOrderView: View{
    let color = Color.theme
    var body: some View{
        VStack{
            HStack{
                Spacer()
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue)
                    .frame(width: 200, height: 75)
                    .overlay(
                        Label(
                            title: { Text("Ordered").font(.title).fontWeight(.semibold).foregroundColor(.white).frame(height: 50)},
                        icon: { Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 50, height: 50) }
                    ))
            }
            Spacer()
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .preferredColorScheme(.dark)
    }
}
