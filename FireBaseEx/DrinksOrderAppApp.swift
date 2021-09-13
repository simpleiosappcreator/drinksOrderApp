//
//  DrinksOrderAppApp.swift
//  DrinksOrderApp
//
//  Created by HAHA on 1/8/2021.
//

import SwiftUI
import Firebase
import Network

@main
struct DrinksOrderAppApp: App {
    @StateObject var orderVM: OrderViewModel = OrderViewModel()
    @StateObject var loginVM: LoginViewModel = LoginViewModel()
    @StateObject var networkVM: NetworkMonitor = NetworkMonitor()
    @StateObject var drinksVM: DrinkViewModel = DrinkViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            LaunchScreen()
                .environmentObject(orderVM)
                .environmentObject(loginVM)
                .environmentObject(networkVM)
                .environmentObject(drinksVM)
        }
    }
}
