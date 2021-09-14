//
//  SignUpView.swift
//  FireBaseEx
//
//  Created by HAHA on 22/8/2021.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var networkVM: NetworkMonitor
    @Environment(\.presentationMode) var presentationMode
    @State var email: String = ""
    @State var password: String = ""
    @State var showCreateSuccessfullyView: Bool = false
    let color = Color.theme
    
    var body: some View {
        ZStack{
            color.background.ignoresSafeArea()
            if !networkVM.isConnected{
                NoWifiView()
            }else{
                VStack{
                    HStack{
                        Text("Sign Up")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding()
                            .background(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)).cornerRadius(15))
                        
                        Spacer()
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title)
                        }
                    }
                    .padding()
                    
                    Image("appLogo")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding()
                    
                    TextField("Email Address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)).cornerRadius(10).opacity(0.4))
                    
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)).cornerRadius(10).opacity(0.4))
                        .padding(.bottom, 25)
                    
                    Button {
                        loginVM.signUp(email: email, password: password)
                        email = ""
                        password = ""
                        if loginVM.signedIn{
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("Create")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)).cornerRadius(25))
                            .opacity(loginVM.checkSignInOrSignUpInput(email: email, password: password) ? 1.0 : 0.5)
                    }
                    .disabled(!loginVM.checkSignInOrSignUpInput(email: email, password: password))
                    .alert(isPresented: $loginVM.wrongSignedUp) {
                        alert()
                    }
                    .withCustomButtonStyle()
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    func alert() -> Alert{
        return Alert(title: Text("1. Invalid email address or 2. email address had been signed up already"), message: nil, dismissButton: .cancel())
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
