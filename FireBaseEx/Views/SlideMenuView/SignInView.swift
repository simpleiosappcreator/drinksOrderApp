//
//  SignInView.swift
//  FireBaseEx
//
//  Created by HAHA on 22/8/2021.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var networkVM: NetworkMonitor
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("save_signin_data") var saveSigninData: Bool = false
    @AppStorage("save_signin_email") var signinEmail: String = ""
    @AppStorage("save_signin_password") var signinPassword: String = ""
    @State var email: String = ""
    @State var password: String = ""
    let color = Color.theme
    
    var body: some View {
        ZStack{
            color.background.ignoresSafeArea()
            if !networkVM.isConnected{
                NoWifiView()
            }else{
                VStack{
                    HStack{
                        Text("Sign in")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding()
                            .background(Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)).cornerRadius(15))
                        
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
                        .padding(.bottom, 10)
                    
                    HStack{
                        Image(systemName: saveSigninData ? "checkmark.circle.fill" : "circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .onTapGesture {
                                saveSigninData.toggle()
                                if !saveSigninData{
                                    signinEmail = ""
                                    signinPassword = ""
                                }
                            }
                        
                        Text("tick for saving data for signing in")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .frame(height: 25)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 25)
                    
                    Button {
                        loginVM.signIn(email: email, password: password)
                        saveSigninDataToDevice()
                        if loginVM.signedIn{
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("Sign in")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)).cornerRadius(25))
                            .opacity(loginVM.checkSignInOrSignUpInput(email: email, password: password) ? 1.0 : 0.5)
                    }
                    .disabled(!loginVM.checkSignInOrSignUpInput(email: email, password: password))
                    .alert(isPresented: $loginVM.wrongSignedIn) {
                        alert()
                    }
                    
                    if loginVM.isLoadingSignIn{
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            getSigninDataFromDevice()
        }
    }
    
    func alert() -> Alert{
        return Alert(title: Text("Wrong email address or password"), message: nil, dismissButton: .cancel())
    }
    
    func saveSigninDataToDevice(){
        if saveSigninData{
            signinEmail = email
            signinPassword = password
        }
    }
    
    func getSigninDataFromDevice(){
        if saveSigninData{
            email = signinEmail
            password = signinPassword
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
