//
//  LoginViewModel.swift
//  FireBaseEx
//
//  Created by HAHA on 23/8/2021.
//

import Foundation
import Firebase
import SwiftUI

class LoginViewModel: ObservableObject{
    static let instance = LoginViewModel()
    
    let auth = Auth.auth()
    
    @Published var signedIn: Bool = false
    @Published var wrongSignedIn: Bool = false
    @Published var wrongSignedUp: Bool = false
    @Published var isLoadingSignIn: Bool = false
    @Published var showCreateSuccessfullyView: Bool = false
    @Published var showLogoutSuccessfullyView: Bool = false
        
    var isSignedIn: Bool {
        return auth.currentUser != nil // return true (current user is logined)
    }
    
    func signIn(email: String, password: String){
        isLoadingSignIn = true
        auth.signIn(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil
            else{
                self?.wrongSignedIn = true
                self?.isLoadingSignIn = false
                return
            }
            
            DispatchQueue.main.async {
                withAnimation(.spring()) {
                    self?.signedIn = true
                    self?.isLoadingSignIn = false
                }
            }
        }
    }
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil
            else{
                self?.wrongSignedUp = true
                return
            }
            
            DispatchQueue.main.async {
                withAnimation(.spring()) {
                    self?.signedIn = true
                    self?.showCreateSuccessfullyView = true
                }
            }
        }
    }
    
    func checkSignInOrSignUpInput(email: String, password: String) -> Bool{
        return email.count > 0 && password.count > 5 ? true : false
    }
    
    func logout(){
        try? auth.signOut()
        withAnimation(.spring()) {
            self.signedIn = false
        }
    }
    
    func turnOffSuccessfullyLogoutView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
            withAnimation(.spring()) {
                self?.showLogoutSuccessfullyView = false
            }
        }
    }
    
    func turnOffSuccessfullyCreateView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {[weak self] in
            withAnimation(.spring()) {
                self?.showCreateSuccessfullyView = false
            }
        }
    }
}
