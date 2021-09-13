//
//  SlideMenuView.swift
//  FireBaseEx
//
//  Created by HAHA on 19/8/2021.
//

import SwiftUI

struct SlideMenuView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var networkVM: NetworkMonitor
    @EnvironmentObject var drinksVM: DrinkViewModel
    @Binding var currentSelection: Int
    @Binding var menuCurrentSelection: Int 
    @State var showSignInView: Bool = false
    @State var showSignUpView: Bool = false
    @State var showLogoutAlert: Bool = false
    
    let menuItem: [MenuItemModel] = [
        MenuItemModel(image: "bookmark", title: "Drinks"),
        MenuItemModel(image: "bubble.left", title: "Snacks"),
        MenuItemModel(image: "cart", title: "Cart")
    ]
    
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0.0)]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            Button(action: {
                withAnimation(.spring()) {
                    orderVM.showSlideMenu.toggle()
                }
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
            })
            .padding()
            
            HStack{
                VStack(alignment: .leading, spacing: 20){
                    
                    NavigationLink(destination: OfficalWebSiteView()) {
                        Image("appLogo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(.bottom)
                    }
                    
                    if loginVM.signedIn{
                        HStack{
                            Text("Sign in")
                                .font(.title2)
                            
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                        }
                        .padding(.bottom, 25)
                    }else{
                        HStack{
                            Button {
                                showSignInView.toggle()
                            } label: {
                                Text("Sign in")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)).cornerRadius(25))
                                    .opacity(networkVM.isConnected ? 1.0 : 0.5)
                            }
                            .disabled(!networkVM.isConnected)
                            .sheet(isPresented: $showSignInView) {
                                SignInView().environmentObject(self.orderVM).environmentObject(self.loginVM).environmentObject(self.networkVM)
                            }
                            
                            Button {
                                showSignUpView.toggle()
                            } label: {
                                Text("Sign up")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)).cornerRadius(25))
                                    .opacity(networkVM.isConnected ? 1.0 : 0.5)
                            }
                            .disabled(!networkVM.isConnected)
                            .sheet(isPresented: $showSignUpView) {
                                SignUpView().environmentObject(self.orderVM).environmentObject(self.loginVM).environmentObject(self.networkVM)
                            }
                        }
                        .padding(.bottom, 25)
                    }
                    
                    VStack(alignment: .leading, spacing: 20){
                        ForEach(0..<menuItem.count) { i in
                            Button {
                                if i != 2{
                                    menuCurrentSelection = i
                                }
                                currentSelection = i
                                withAnimation(.spring()) {
                                    orderVM.showSlideMenu = false
                                }
                            } label: {
                                HStack{
                                    Image(systemName: menuItem[i].image)
                                        .frame(width: 24, height: 24)
                                    Text(menuItem[i].title)
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 15)
                            
                    Spacer()
                    
                    if loginVM.signedIn{
                        LogoutView()
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            
            if loginVM.showLogoutSuccessfullyView{
                ZStack{
                    LogoutSuccessfullyView()
                        .transition(.move(edge: .trailing))
                        .onAppear(perform: loginVM.turnOffSuccessfullyLogoutView)
                }
                .zIndex(1.0)
            }
            
            if loginVM.showCreateSuccessfullyView{
                ZStack{
                    CreateSuccessfullyView()
                        .transition(.move(edge: .trailing))
                        .onAppear(perform: loginVM.turnOffSuccessfullyCreateView)
                }
                .zIndex(1.0)
            }
        }
        .navigationBarHidden(true)
    }
}

struct LogoutSuccessfullyView: View{
    var body: some View{
        VStack{
            HStack{
                Spacer()
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray)
                    .frame(width: 120, height: 70)
                    .overlay(
                        Label {
                            Text("Logout")
                                .font(.title2)
                                .frame(height: 70)
                        } icon: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                                .frame(height: 70)
                        }
                    )
            }
            Spacer()
        }
        .padding()
    }
}

struct CreateSuccessfullyView: View{
    var body: some View{
        VStack{
            HStack{
                Spacer()
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray)
                    .frame(width: 150, height: 70)
                    .overlay(
                        Label {
                            Text("Created")
                                .font(.title2)
                                .frame(height: 70)
                        } icon: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                                .frame(height: 70)
                        }
                    )
            }
            Spacer()
        }
        .padding()
    }
}

struct OfficalWebSiteView: View{
    var body: some View{
        UrlWebView(urlString: "https://www.apple.com/hk/")
            .navigationTitle("Offical Website")
    }
}

struct SlideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuView(currentSelection: .constant(1), menuCurrentSelection: .constant(1))
    }
}
