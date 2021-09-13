//
//  LogoutView.swift
//  FireBaseEx
//
//  Created by HAHA on 26/8/2021.
//

import SwiftUI

struct LogoutView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var networkVM: NetworkMonitor
    @State var showLogoutAlert: Bool = false
    
    var body: some View {
        Button {
            showLogoutAlert = true
        } label: {
            HStack{
                Image(systemName: "arrow.left.square")
                    .frame(width: 24, height: 24)
                Text("Logout")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
            }
            .opacity(networkVM.isConnected ? 1.0 : 0.5)
        }
        .alert(isPresented: $showLogoutAlert, content: {
            alertLogout()
        })
        .disabled(!networkVM.isConnected)
    }
    
    func alertLogout() -> Alert{
        return Alert(title: Text("Are you sure to logout?"), primaryButton: .cancel(Text("No")), secondaryButton: .destructive(Text("Yes"), action: {
            if networkVM.isConnected{
                loginVM.logout()
                withAnimation(.spring()) {
                    loginVM.showLogoutSuccessfullyView.toggle()
                }
            }
        }))
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
