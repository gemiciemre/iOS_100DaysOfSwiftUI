//
//  ExpenseItem.swift
//  Day36-iExpense-Project7
//
//  Created by Emre Gemici on 29.11.2022.
//

import Foundation

struct ExpenseItem : Identifiable, Codable{
    var id = UUID()
    let name : String
    let type : String
    let amount : Double
    var currencyCode : String // bu değişken sabitken gönderdiğim değerler first View da 0 gösteriyordu.
}
