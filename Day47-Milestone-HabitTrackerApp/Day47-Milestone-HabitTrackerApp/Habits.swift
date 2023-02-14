//
//  Habits.swift
//  Day47-Milestone-HabitTrackerApp
//
//  Created by Emre Gemici on 14.02.2023.
//

import Foundation

class Habits: ObservableObject{
    @Published var habitItems = [HabitItem](){
        didSet{
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(habitItems){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try?JSONDecoder().decode([HabitItem].self, from: savedItems){
                habitItems = decodedItems
                return
            }
        }
        habitItems = []
    }
    
}
