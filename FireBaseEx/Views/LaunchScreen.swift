//
//  Launch.swift
//  FireBaseEx
//
//  Created by HAHA on 8/9/2021.
//

import SwiftUI

struct LaunchScreen: View {
    @State var showLaunchScreen: Bool = true
    @State var angle: Angle = Angle(degrees: 0)
    let color = Color.theme
    
    var body: some View {
        if showLaunchScreen{
            GeometryReader{geometry in
                ZStack{
                    color.background.ignoresSafeArea()
                    
                    Image("appLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                        .rotationEffect(angle)
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.spring(response: 1.5)) {
                                    angle = Angle(degrees: 360)
                                }                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                withAnimation(.linear) {
                                    showLaunchScreen = false
                                }
                            }
                        }
                }
            }
        }
        else{
            HomeView()
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
