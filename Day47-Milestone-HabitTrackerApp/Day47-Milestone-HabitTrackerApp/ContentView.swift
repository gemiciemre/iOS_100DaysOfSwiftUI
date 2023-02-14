//
//  ContentView.swift
//  Day47-Milestone-HabitTrackerApp
//
//  Created by Emre Gemici on 13.02.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showingAddHabit = false
    @State private var increasing = false
    @State private var decreasing = false
    @State private var amount = 0
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    ForEach(habits.habitItems){item in
                        NavigationLink{
                            HabitView(habit: item)
                        }label: {
                            VStack{
                                HStack(){
                                    Stepper(value:$amount, in: 0...20){
                                        Text("\(item.habitName) : \()")//
                                    }
    //                                Text(item.habitName)
    //                                Spacer()
    //                                Button{
    //                                    increasing = true
    //                                }label: {
    //                                    Image(systemName: "minus")
    //                                }.padding()
    //                                Button{
    //                                    increasing = true
    //                                }label: {
    //                                    Image(systemName: "plus")
    //                                }
                                }
                            }
                        }
                    }
                    .onDelete(perform: removeHabitItems)
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar{
                Button{
                    showingAddHabit = true
                }label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddHabit){
            AddView(habits: habits)
        }
    }
    
    func removeHabitItems(at offset: IndexSet){
        habits.habitItems.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
