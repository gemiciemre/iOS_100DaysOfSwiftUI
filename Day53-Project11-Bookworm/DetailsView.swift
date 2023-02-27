//
//  DetailsView.swift
//  Day53-Project11-Bookworm
//
//  Created by Emre Gemici on 27.02.2023.
//

import CoreData
import SwiftUI

struct DetailsView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book : Book
    
    var body: some View {
        ScrollView{
            ZStack(alignment:.bottomTrailing){
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                Text(book.genre?.uppercased() ?? "Fantasy")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x:-5, y: -5)
            }
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No review")
                .padding()
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .alert("Delete Book",isPresented:$showingDeleteAlert){
            Button("Delete",role: .destructive, action: deleteBook)
            Button("Cancel",role: .cancel){ }
        }message: {
            Text("Are you sure?")
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            Button{
                showingDeleteAlert = true
            }label: {
                Label("Delete this book",systemImage: "trash")
            }
        }
    }
    func deleteBook(){
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
}


