//
//  ContentView.swift
//  Day35-Milestone-Project4-6
//
//  Created by Emre Gemici on 24.11.2022.
//

import SwiftUI

struct Question : Identifiable {
    let id = UUID()
    var level = ["easy","medium","hard"]
    var text : String
    var answer : String
}

struct ContentView: View {
    
    @State private var timesTable = 2
    @State private var questionsNumbers = ["5","10","15","20"] // burada arrayin ici string olması lazım picker ı kullanabilmemiz için
    @State private var showLevel = "Easy"
    @State private var numberOfQuestion : String = "5" //neden String olması gerekiyor ben buradan Int deger cekemez miyim ?
    @State private var level : Float = 0 // burada da int kullanamaz mıydık ?
    @State private var answerQuestion : String = "" // burada String e initialize etmek zorundasın
    @State private var score = 0
    @State private var showingError = false
    
   // @State private var questions = ["hard1":"hardQ","hard2": "hardQ2"]
    @State private var questions = [
        Question(level:["easy"], text: "2 x 3", answer: "6"),
        Question(level:["easy"], text: "2 x 4", answer: "8"),
        Question(level:["medium"],text: "5 x 7", answer: "35"),
        Question(level: ["medium"], text: "6 x 3", answer: "18"),
        Question(level:["hard"], text: "8 x 7", answer: "56"),
        Question(level:["hard"], text: "6 x 9", answer: "54")
    ]
    
    
    var body: some View {
        Form{
            Section{
                Stepper("\(timesTable). Times Table",value: $timesTable, in: 2...12) // burada da times table ı aldık.
            } header: {
                Text("Select Multiplication Table")
            }
            Section{
                //Text("How many question ?")
                Picker("How many question ?", selection:$numberOfQuestion){ // burada kaç tane soru geliceğini aldık.
                    ForEach(questionsNumbers, id: \.self){
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            } header: {
                Text("How many question ?")
            }
            Section{
                Slider(value:$level,in:1...3,step: 1.0){
                    if (level == 2.0){
                        //self.showLevel = "Medium"
                    }
                    else if (level == 3.0){
                        //self.showLevel = "Hard"
                    }
                    //Text("Level")
                }minimumValueLabel: {
                    Text("Easy")
                } maximumValueLabel: {
                    Text("Hard")
                }.accentColor((level == 2.0) ? Color.blue : Color.red) // burası çok önemli $level = 2.0 ? .red :.blue
                
            } header: {
                Text("Question Level : \(showLevel)")
            }
            Section{
                Button("Show"){
                    
                }
            }
            VStack{
             Text("Question")
                    Spacer()
                    .foregroundColor(.primary)
                    .font(.title3)
                //Text(showQuestion)
                VStack{
                    ForEach(questions) { question in
                        if question.level == ["easy"]{
                            Text(question.text) // burada sadece bir soru göstermem gerekiyor.
                        }
                    }
                }
                VStack{
                    TextField("Answer", text:$answerQuestion )
                        .textFieldStyle(.roundedBorder)
                }
                VStack{
                    Button("Save"){
                        if answerQuestion.isEmpty{
                            showingError = true
                        }
                        else{
                            // Buraya yeni soru getireceğiz.
                            //Burada Cevap Kontrolü yapacağız.
                        }
                    }
                    .alert("Error!", isPresented: $showingError) {
                                Button("OK") { }
                    }message: {
                        Text("Please,Reply ")
                    }
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
