//
//  NoWifiView.swift
//  FireBaseEx
//
//  Created by HAHA on 8/9/2021.
//

import SwiftUI

struct NoWifiView: View {
    let color = Color.theme
    var body: some View {
        VStack{
            Image(systemName: "wifi.slash")
                .font(.title)
                .padding(.bottom, 20)
            
            Text("No internet connect!")
                .font(.title)
                .foregroundColor(color.secondary)
        }
    }
}

struct NoWifiView_Previews: PreviewProvider {
    static var previews: some View {
        NoWifiView()
    }
}
