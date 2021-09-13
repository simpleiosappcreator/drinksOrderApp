//
//  SnackMenuView.swift
//  FireBaseEx
//
//  Created by HAHA on 19/8/2021.
//

import SwiftUI

struct SnackMenuView: View {
    let color = Color.theme
    
    var body: some View {
        ZStack{
            color.background.ignoresSafeArea()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct SnackMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SnackMenuView()
    }
}
