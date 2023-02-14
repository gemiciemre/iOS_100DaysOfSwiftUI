//
//  HabitView.swift
//  Day47-Milestone-HabitTrackerApp
//
//  Created by Emre Gemici on 14.02.2023.
//

import SwiftUI

struct HabitView: View {
    
    let habit: HabitItem
    
    var body: some View {
            ScrollView{
                VStack{
                    Text(habit.habitName)
                        .font(.title.bold())
                        .padding()
                    Text("Amount : \(habit.amount)")
                        .foregroundColor(.black)
                    VStack{
                        Rectangle()
                            .frame(height: 0.5)
                            .foregroundColor(.secondary)
                            .padding(.vertical)
                        Text(habit.description)
                    }
                    .padding(.horizontal)
                }
            }
    }
    init(habit: HabitItem) {
        self.habit = habit
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habit: HabitItem(habitName: "deneme", description: "denemeeeeeeeeeeeeee", amount: 0))
    }
}
