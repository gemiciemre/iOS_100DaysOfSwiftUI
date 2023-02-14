//
//  HabitItem.swift
//  Day47-Milestone-HabitTrackerApp
//
//  Created by Emre Gemici on 14.02.2023.
//

import Foundation

struct HabitItem: Identifiable,Codable {
    var id = UUID()
    let habitName : String
    let description : String
    var amount : Int
}
