//
//  ShowCustomerInfoSheet.swift
//  FireBaseEx
//
//  Created by HAHA on 20/8/2021.
//

import SwiftUI

struct ShowCustomerInfoSheet: View {
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var loginVM: LoginViewModel
    @AppStorage("save_customer_info") var saveCustomerInfo: Bool = false
    @AppStorage("customer_name") var customerName: String = ""
    @AppStorage("customer_phone_number") var customerPhoneNumber: String = ""
    @AppStorage("delivery_location") var deliveryLocation: String = ""
    @State var name: String = ""
    @State var phone: String = ""
    @State var location: String = ""
    @Environment (\.presentationMode) var presentationMode
    let color = Color.theme
        
    var body: some View {
        VStack{
            VStack{
                HStack {
                    Spacer()
                    
                    Text("Current customer's information").font(.headline).fontWeight(.semibold).foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.body)
                    })
                }
                .padding()
            }
            .background(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
            .padding(.bottom, 30)
            
            HStack{
                Text("Sign in")
                    .font(.title2)
                if loginVM.signedIn{
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                }else{
                    Image(systemName: "multiply.circle.fill")
                        .font(.title2)
                }
            }
            
            Divider()
                .frame(height: 25)
            
            Text("Customer can modify your information in cart section")
                .multilineTextAlignment(.center)
            
            HStack{
                VStack(alignment: .leading) {
                    Text("Customer's name")
                        .foregroundColor(color.secondary)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(name)
                        .foregroundColor(.white)
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)).cornerRadius(10).opacity(0.4))
                    
                    Text("Customer's phone number")
                        .foregroundColor(color.secondary)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(phone)
                        .foregroundColor(.white)
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)).cornerRadius(10).opacity(0.4))
                     
                    Text("Delivery location")
                        .foregroundColor(color.secondary)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(location)
                        .foregroundColor(.white)
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)).cornerRadius(10).opacity(0.4))
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                Spacer()
            }
            
            Spacer()
        }
        .onAppear {
            loadingCustomerInfo()
        }
    }
    
    func loadingCustomerInfo(){
        if saveCustomerInfo{
            name = customerName
            phone = customerPhoneNumber
            location = deliveryLocation
        }else{
            name = orderVM.customerName
            phone = orderVM.customerPhoneNumber
            location = orderVM.deliveryLocation
        }
    }
}

struct ShowCustomerInfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        ShowCustomerInfoSheet()
    }
}
