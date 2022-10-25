//
//  ContentView.swift
//  Day28-Project4-BetterRest
//
//  Created by Emre Gemici on 24.10.2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeUp
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultWakeUp : Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
        
    }
    
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView{
            Form{
                VStack(alignment: .leading,spacing: 0){
                    
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please Enter A Time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                VStack(alignment: .leading,spacing: 0){
                    Text("Desired Amount of Sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                VStack(alignment: .leading,spacing: 0){
                    Text("Daily Coffee Intake")
                        .font(.headline)
                    
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                }
            }
            .navigationTitle("Better Rest")
            //.navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Button("Calculate", action: calculateBedTime)
            }
            .alert(alertTitle, isPresented: $showingAlert){
                Button("OK"){}
            } message: {
                Text(alertMessage)
            }
        }
    }
    func calculateBedTime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bed time is "
            alertMessage = sleepTime.formatted(date: .omitted, time:.shortened)
            
        }
        catch{
            // Oops some error!
            alertTitle = "Error"
            alertMessage = "Sorry, Something is wrong!"
        }
        showingAlert = true
    }
}
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

/*
 @State private var sleepAmount = 8.0
 @State private var wakeUp = Date.now
 
 var components = DateComponents()
 
 ZStack{
     VStack {
         Stepper("\(sleepAmount.formatted()) hours ", value: $sleepAmount, in: 2...12, step: 0.25)
         DatePicker("Please Enter A Date" , selection: $wakeUp, displayedComponents:.hourAndMinute)
         Text(Date.now.formatted(date: .long, time:.shortened))
         

     }
     .padding()
 
 mutating func trivialExample(){
     components.hour = 8
     components.minute = 0
     let date = Calendar.current.date(from: components)
 }
 }
 
 
 */
