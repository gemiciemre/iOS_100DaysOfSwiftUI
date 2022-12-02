//
//  Expenses.swift
//  Day36-iExpense-Project7
//
//  Created by Emre Gemici on 29.11.2022.
//

import Foundation

class Expenses : ObservableObject{
    @Published var personal = [ExpenseItem](){
        
        
        didSet{
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(personal){
                UserDefaults.standard.set(encoded, forKey: "Personal")
            }
        }
    }
    
//    @Published var business = [ExpenseItem](){
//
//        didSet{
//            let encoder = JSONEncoder()
//
//            if let encoded = try? encoder.encode(business){
//                UserDefaults.standard.set(encoded, forKey: "Business")
//            }
//        }
//    }

    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Personal"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                personal = decodedItems
                return
            }
        }
        personal = []
        
//        if let savedItems = UserDefaults.standard.data(forKey: "Business"){
//            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
//                business = decodedItems
//                return
//            }
//        }
//        business = []
    }
}

class BusinessClass : ObservableObject{
    @Published var business = [ExpenseItem](){
        
        didSet{
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(business){
                UserDefaults.standard.set(encoded, forKey: "Business")
            }
        }
    }
    
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Business"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                business = decodedItems
                return
            }
        }
        business = []
    }

}
