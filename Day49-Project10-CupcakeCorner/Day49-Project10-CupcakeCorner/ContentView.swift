//
//  ContentView.swift
//  Day49-Project10-CupcakeCorner
//
//  Created by Emre Gemici on 16.02.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.type){
                        ForEach(Order.types.indices){ //dizi içerisindeki verileri indexler ile eşleyebilmemiz için kullanılıyor.
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)",value: $order.quantity,in: 3...20)
                }
                Section{
                    Toggle("Any special request?", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled{
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section{
                    NavigationLink{
                        AddressView(order: order)
                    }label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
