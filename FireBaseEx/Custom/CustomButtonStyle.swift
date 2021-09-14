//
//  CustomButtonStyle.swift
//  FireBaseEx
//
//  Created by HAHA on 14/9/2021.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle{
    let scale: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? scale : 1.0)
    }
}

extension View{
    func withCustomButtonStyle(scale: CGFloat = 1.2) -> some View{
        buttonStyle(CustomButtonStyle(scale: scale))
    }
}
