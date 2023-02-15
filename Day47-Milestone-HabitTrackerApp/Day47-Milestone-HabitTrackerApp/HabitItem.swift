//
//  HabitItem.swift
//  Day47-Milestone-HabitTrackerApp
//
//  Created by Emre Gemici on 14.02.2023.
//

import Foundation

struct HabitItem: Identifiable,Codable {
    var id = UUID()
    var habitName : String
    var description : String
    var amount : Int
}
