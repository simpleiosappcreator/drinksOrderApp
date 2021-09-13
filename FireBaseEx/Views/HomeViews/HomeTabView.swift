//
//  ContentView.swift
//  DrinksOrderApp
//
//  Created by HAHA on 1/8/2021.
//

import SwiftUI

struct HomeTabView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var network: NetworkMonitor
    @Binding var currentSelection: Int
    @Binding var menuCurrentSelection: Int
    let color = Color.theme
    
    var body: some View {
        ZStack{
            color.background.ignoresSafeArea()
            TabView(selection: $currentSelection,
                    content:  {
                        if !network.isConnected{
                            NoWifiView()
                        }else{
                            MenuView(menuCurrentSelection: $menuCurrentSelection)
                                .tabItem {
                                    VStack{
                                        Image(systemName: "house.fill")
                                        Text("Menu")
                                    }
                                }
                                .tag(menuCurrentSelection)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        orderVM.showSlideMenu = false
                                    }
                                }
                        }
                        if !network.isConnected{
                            NoWifiView()
                        }else{
                            CartView()
                                .tabItem {
                                    VStack{
                                        Image(systemName: "cart.fill")
                                        Text("Cart")
                                    }
                                }
                                .tag(2)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        orderVM.showSlideMenu = false
                                    }
                                }
                        }
                    })
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView(currentSelection: .constant(1), menuCurrentSelection: .constant(1))
            .preferredColorScheme(.dark)
    }
}
