//
//  ContentView.swift
//  Day29-Project5-WorldScramble
//
//  Created by Emre Gemici on 31.10.2022.
//

import SwiftUI


struct SingleLetterView : View {
    let letter: String
    
    let backgroungColor = Color(red: 1.0, green: 0.95, blue: 0.9)
    let borderColor = Color(red: 0.8, green: 0.75, blue: 0.7)
    let rotation = Double.random(in: -4.0..<4.0)
    
    var body: some View{
        Text(letter)
            .font(.custom("American Typewriter", size: 36))
            .foregroundColor(.black)
            .frame(width: 36,height: 48)
            .background(backgroungColor)
            .cornerRadius(5)
            .overlay{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(borderColor,lineWidth: 1)
            }
            .rotationEffect(.degrees(rotation))
            .shadow(color: .black.opacity(0.2), radius: 3,x: 1,y: 2)
    }
}

struct WorldView: View {
    
    let word : String
    let indices : [Int]?
    
    var letters: [String]{
        word.map({String($0)})
    }
    
    init(word: String, indices: [Int]?=nil) {
        self.word = word
        self.indices = indices
    }
    
    var body: some View{
        HStack{
            ForEach(letters.indices, id: \.self){ index in
                SingleLetterView(letter: letters[index])
            }
        }
    }
}




struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0 // Third Challenge
    @State private var restartTheGame = false
    
    
    var body: some View {
        NavigationView(){
            List{
                WorldView(word: rootWord)
                Section("Score : \(score)"){
                    TextField("Enter Your Word", text: $newWord)
                        .autocapitalization(.none)
                    
                }
                Section(){
                    ForEach(usedWords , id: \.self){word in
                        HStack{
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError){
                Button("OK", role: .cancel){}
            }message: {
                Text(errorMessage)
            }
            .toolbar{
                Button("Restart"){ // Second Challenge
                    startGame()
                }
            }
            .alert("You Lose!",isPresented: $restartTheGame){
                Button("OK"){
                    startGame()
                }
                Button("Cancel"){
                    exit(0)
                }
            }
        }
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {return}
        
        guard isOriginal(word: answer) else{
            wordError(title: "Word used already", message: "Be more original !")
            if score == 0{
                restartTheGame = true
            }
            else{
                score -= 1
            }
            return
        }
        guard isPossible(word: answer) else{
            wordError(title: "Word not possible", message: "You can't spell that word from")
            if score == 0{
                restartTheGame = true
            }
            else{
                score -= 1
            }
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognize", message: "You can't just make them up, you know!")
            if score == 0{
                restartTheGame = true
            }
            else{
                score -= 1
            }
            return
        }
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
        score += answer.count
        
    }
    
    func startGame (){
        score = 0
        usedWords.removeAll()
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "Silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    func isOriginal(word:String)-> Bool{
        !usedWords.contains(word)
    }
    func isPossible(word:String)-> Bool{
        var tempWord = rootWord
        
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }
            else{
                return false
            }
        }
        return true
    }
    
    func isReal(word:String) ->Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        if word.count < 3 || word == rootWord { // First Challenge
            return false
        }
        
        return misspelledRange.location == NSNotFound
        
    }
    
    func wordError(title : String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}
  

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
}
