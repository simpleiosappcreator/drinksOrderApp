//
//  MenuView.swift
//  FireBaseEx
//
//  Created by HAHA on 19/8/2021.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    @Binding var menuCurrentSelection: Int
    
    var body: some View {
        switch menuCurrentSelection{
        case 0:
            DrinksMenuView()
        default:
            SnackMenuView()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(menuCurrentSelection: .constant(1))
    }
}
