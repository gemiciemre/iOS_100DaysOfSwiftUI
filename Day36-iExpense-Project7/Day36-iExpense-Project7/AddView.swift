//
//  AddView.swift
//  Day36-iExpense-Project7
//
//  Created by Emre Gemici on 29.11.2022.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses : Expenses
    @ObservedObject var businessExpenses : BusinessClass // burada Classı tanımlıyoruz.
    
    @Environment(\.dismiss) var dissmiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currencyCodes = ["USD","TRY","EUR","JPY"]
    @State private var currencyCode = "USD"
    
    let types = ["Business","Personal"]
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type){
                    ForEach(types, id:\.self){
                        Text($0)
                    }
                }
                HStack{
                    TextField("Amount", value:$amount, format: .currency(code: "\(currencyCode)"))
                            .keyboardType(.decimalPad)
                    Picker("",selection:$currencyCode ){
                        ForEach(currencyCodes,id:\.self){
                            Text($0)
                        }
                    }
                    
                }
                
            }
            .navigationTitle("Add Expense")
            .toolbar{
                Button("Save"){
                    let item = ExpenseItem(name:name,type:type, amount: amount,currencyCode: currencyCode)
                    if item.type == "Personal"{
                        expenses.personal.append(item)
                    }
                    else if item.type == "Business"{
                        businessExpenses.business.append(item)
                    }
        
                    dissmiss()
                }
            }
        }

    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses(), businessExpenses : BusinessClass()) //burada ki hatayı anlamadım.
    }
}
