import UIKit

class Statue {
    var sculptor = "Unknown"
}
var venusDeMilo = Statue()
venusDeMilo.sculptor = "Alexandros of Antioch"
var david = Statue()
david.sculptor = "Michaelangelo"
print(venusDeMilo.sculptor)
print(david.sculptor)

class Magazine {
    var pageCount = 132
}
var example = Magazine()
print(Magazine().pageCount)
var wired = example
wired.pageCount = 164
print(Magazine().pageCount)
var vogue = example
vogue.pageCount = 128
wired.pageCount = 45
print(wired.pageCount)
print(vogue.pageCount)
print(Magazine().pageCount)
print(example.pageCount)
