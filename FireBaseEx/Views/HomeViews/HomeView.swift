//
//  HomeView.swift
//  FireBaseEx
//
//  Created by HAHA on 19/8/2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var networkVM: NetworkMonitor
    @EnvironmentObject var drinksVM: DrinkViewModel
    @State var showCustomerInfoSheet: Bool = false
    @State var currentSelection: Int = 0
    @State var menuCurrentSelection: Int = 0
    
    var body: some View {
        NavigationView{
            ZStack{
                if orderVM.showSlideMenu{
                    SlideMenuView(currentSelection: $currentSelection, menuCurrentSelection: $menuCurrentSelection)
                }
                
                HomeTabView(currentSelection: $currentSelection, menuCurrentSelection: $menuCurrentSelection)
                    .navigationBarItems(leading: Button(action: {
                        withAnimation(.spring()) {
                            orderVM.showSlideMenu.toggle()
                        }
                    }, label: {
                        Image(systemName: "list.bullet")
                            .font(.title2)
                    }),
                    trailing: Button(action: {
                    showCustomerInfoSheet.toggle()
                }, label: {
                    Image(systemName: "person.fill")
                        .font(.title2)
                }).sheet(isPresented: $showCustomerInfoSheet, content: {
                    ShowCustomerInfoSheet()
                }) )
                    .navigationTitle(currentSelection == 0 ? "Drinks" : currentSelection == 1 ? "Snacks" : "Cart")
                    .cornerRadius(orderVM.showSlideMenu ? 15 : 0)
                    .offset(x: orderVM.showSlideMenu ? 250 : 0, y: orderVM.showSlideMenu ? 50 : 0)
                    .scaleEffect(orderVM.showSlideMenu ? 0.8 : 1.0)
                    .shadow(color: .black.opacity(0.5), radius: 10, x: orderVM.showSlideMenu ? -10 : 0, y: orderVM.showSlideMenu ? -10 : 0)
                    .navigationBarTitleDisplayMode(.inline)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                if value.translation.width > 10{
                                    withAnimation(.spring()) {
                                        orderVM.showSlideMenu = true
                                    }
                                }else if value.translation.width < -10{
                                    withAnimation(.spring()) {
                                        orderVM.showSlideMenu = false
                                    }
                                }
                            })
                    )
            }
            .onAppear(perform: {
                withAnimation(.spring()) {
                    orderVM.showSlideMenu = false
                }
                loginVM.signedIn = loginVM.isSignedIn
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
