import UIKit

struct Book {
let title: String
let author: String?
}

var book: Book? = Book(title: "Baslangic", author: "zanBrown")
let author = book?.author?.first?.uppercased() ?? "A"

print(author)
