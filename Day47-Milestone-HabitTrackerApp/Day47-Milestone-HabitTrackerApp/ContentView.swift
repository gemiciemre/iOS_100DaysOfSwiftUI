//
//  ContentView.swift
//  Day47-Milestone-HabitTrackerApp
//
//  Created by Emre Gemici on 13.02.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                Text("Deneme")
            }
            .navigationTitle("Habit Tracker")
            .padding([.horizontal,.bottom])
            .toolbar{
                Button{
                    showingAddHabit = true
                }label: {
                    Image(systemName: "plus")
                }
            }
        }

        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
