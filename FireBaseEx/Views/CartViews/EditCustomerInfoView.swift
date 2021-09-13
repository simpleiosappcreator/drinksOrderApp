//
//  EidtCustomerInfoView.swift
//  FireBaseEx
//
//  Created by HAHA on 16/8/2021.
//

import SwiftUI

struct EditCustomerInfoView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    @Environment (\.presentationMode) var presentationMode
    @AppStorage("save_customer_info") var saveCustomerInfo: Bool = false
    @AppStorage("customer_name") var customerName: String = ""
    @AppStorage("customer_phone_number") var customerPhoneNumber: String = ""
    @AppStorage("delivery_location") var deliveryLocation: String = ""
    @State var name: String = ""
    @State var phoneNumber: String = ""
    @State var location: String = ""
    @Binding var isCompletedCustomerInfoSheet: Bool
    let color = Color.theme
    
    var body: some View {
        VStack{
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.body)
                    })
                    
                    Spacer()
                    
                    Text("Customer's information").font(.headline).fontWeight(.semibold).foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        saveCustomerInfoToDevice()
                        orderVM.editCustomerInfo(name: name, phoneNumber: phoneNumber, location: location)
                        isCompletedCustomerInfoSheet = true
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Finish")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                            .opacity(orderVM.checkCustomerInfo(name: name, phoneNumber: phoneNumber, location: location) ? 1.0 : 0.5)
                    })
                    .disabled(!orderVM.checkCustomerInfo(name: name, phoneNumber: phoneNumber, location: location))
                }
                .padding()
            }
            .background(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
            
            VStack(alignment: .leading) {
                Text("Customer's name")
                    .foregroundColor(color.secondary)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                TextField("Customer's name", text: $name)
                    .disableAutocorrection(true)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)).cornerRadius(10).opacity(0.4))
                
                Text("Customer's phone number")
                    .foregroundColor(color.secondary)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                TextField("Customer's phone number", text: $phoneNumber)
                    .disableAutocorrection(true)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)).cornerRadius(10).opacity(0.4))
                 
                Text("Delivery location")
                    .foregroundColor(color.secondary)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                TextField("Delivery location", text: $location)
                    .disableAutocorrection(true)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)).cornerRadius(10).opacity(0.4))
            }
            .padding()
            
            HStack{
                Image(systemName: saveCustomerInfo ? "checkmark.circle.fill" : "circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        saveCustomerInfo.toggle()
                    }
                
                Text("tick for saving customer's information")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .frame(height: 25)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .onAppear(perform: {
            getCustomerInfoFromDevice()
        })
    }
    
    func saveCustomerInfoToDevice(){
        if saveCustomerInfo{
            customerName = name
            customerPhoneNumber = phoneNumber
            deliveryLocation = location
        }else{
            customerName = ""
            customerPhoneNumber = ""
            deliveryLocation = ""
        }
    }
    
    func getCustomerInfoFromDevice(){
        if saveCustomerInfo{
            name = customerName
            phoneNumber = customerPhoneNumber
            location = deliveryLocation
        }
    }
}

struct EditCustomerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EditCustomerInfoView(isCompletedCustomerInfoSheet: .constant(true))
    }
}
