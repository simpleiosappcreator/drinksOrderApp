//
//  DrinkNavigationLinkCoverView.swift
//  DrinksOrderApp
//
//  Created by HAHA on 1/8/2021.
//

import SwiftUI

struct DrinkNavigationLinkLabelView: View {
    let drinkName: String
    let availableStatus: String
    let color = Color.theme
    @StateObject var drinkImageVM: DrinkImageViewModel
    
    init(key: String, url: String, name: String, status: String){
        _drinkImageVM = StateObject(wrappedValue: DrinkImageViewModel(url: url, key: key))
        self.drinkName = name
        self.availableStatus = status
    }
    var body: some View {
        VStack{
            if drinkImageVM.isLoading{
                ProgressView()
            }else if let image = drinkImageVM.image{
                Image(uiImage: image)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.45)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }else{
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.45)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            
            VStack{
                Text(drinkName)
                    .foregroundColor(color.secondary)
                    .font(.headline)
                Text(availableStatus)
                    .foregroundColor(color.secondary)
                    .font(.body)
            }
            .padding(.bottom)
        }
    }
}

struct DrinkNavigationLinkLabelView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkNavigationLinkLabelView(key: "", url: "", name: "", status: "")
    }
}
