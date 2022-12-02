//
//  ContentView.swift
//  Day36-iExpense-Project7
//
//  Created by Emre Gemici on 29.11.2022.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject var expenses = Expenses() // burada sınıfı tanımlarken private olarak tanımlamıyorsun.
    @StateObject var business = BusinessClass() // burada ayrı oluşturduğum Business Class sınıfını tanımlıyorum.
    @State private var showingAddExpense = false

    
    var body: some View {
        NavigationView{
            List{
                Section("Personal"){
                    ForEach(expenses.personal){item in
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: "\(item.currencyCode)"))
                        }
                        .foregroundColor(item.amount >= 100 ? .orange : item.amount < 10 ? .green : .blue)
                    }
                    .onDelete(perform: removePersonalItems)
                }
                Section("Busıness"){
                    ForEach(business.business){item in
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: "\(item.currencyCode)"))
                        }
                        .foregroundColor(item.amount >= 100 ? .orange : item.amount < 10 ? .green : .blue)
                    }
                    .onDelete(perform: removeBusinessItems)
                }
            }
            //.listStyle(GroupedListStyle()) // sonradan eklendi
            .navigationTitle("iExpense")
            .toolbar{
                Button{
                    showingAddExpense = true
                }label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense){
            AddView(expenses: expenses, businessExpenses: business)
        }
    }
    func removePersonalItems(at offsets : IndexSet){
        expenses.personal.remove(atOffsets: offsets)
    }
    func removeBusinessItems(at offsets : IndexSet){
        business.business.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
