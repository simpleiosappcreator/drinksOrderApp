//
//  DrinksMenuVies.swift
//  DrinksOrderApp
//
//  Created by HAHA on 1/8/2021.
//

import SwiftUI

struct DrinksMenuView: View {
    @EnvironmentObject var drinksVM: DrinkViewModel
    let column: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: column, content: {
                ForEach(drinksVM.drinks) { drink in
                    DrinkNavigationLinkView(drink: drink)
                }
            })
        }
    }
}

struct DrinksMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DrinksMenuView()
    }
}
