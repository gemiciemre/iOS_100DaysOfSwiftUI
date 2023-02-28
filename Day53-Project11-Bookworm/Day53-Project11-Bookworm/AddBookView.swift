//
//  AddBookView.swift
//  Day53-Project11-Bookworm
//
//  Created by Emre Gemici on 23.02.2023.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc // bu ne için
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    @State private var date = ""
    
    let genres = ["Fantasy", "Horror","Kids", "Mystery", "Poetry","Romance","Thriller"]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name of Book",text: $title)
                    TextField("Author",text: $author)
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                Section{
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }header: {
                    Text("Write Review")
                }
                Section{
                    Button("Save"){
                        //add the book
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.genre = genre
                        newBook.rating = Int16(rating)
                        newBook.review = review
                        newBook.date = Date.now
                        
                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
