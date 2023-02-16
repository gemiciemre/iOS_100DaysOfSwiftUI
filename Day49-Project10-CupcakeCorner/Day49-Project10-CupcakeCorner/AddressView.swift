//
//  AddressView.swift
//  Day49-Project10-CupcakeCorner
//
//  Created by Emre Gemici on 16.02.2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order : Order
    
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.name)
                TextField("Street Address", text:$order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            Section{
                NavigationLink{
                    CheckoutView(order: order)
                }label: {
                    Text("Check out")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Deliver details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
