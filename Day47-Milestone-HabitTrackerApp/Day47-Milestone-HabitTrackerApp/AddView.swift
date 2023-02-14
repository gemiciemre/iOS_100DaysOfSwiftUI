//
//  AddView.swift
//  Day47-Milestone-HabitTrackerApp
//
//  Created by Emre Gemici on 14.02.2023.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var habits : Habits
    
    @State private var title : String = ""
    @State private var description : String = ""
    @State private var amount: Int = 0
    
    @Environment(\.dismiss) var dissmiss
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add Habit")
            .toolbar{
                Button("Save"){
                    let item = HabitItem(habitName : title, description : description, amount : amount)
                    habits.habitItems.append(item)
                    dissmiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
