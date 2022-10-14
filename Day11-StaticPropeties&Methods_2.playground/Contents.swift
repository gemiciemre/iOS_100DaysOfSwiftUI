import UIKit


struct Cat {
    static var allCats = [Cat]()
    init() {
        Cat.allCats.append(self)
    }
    static func chorus() {
        for _ in allCats {
            print("Meow!")
        }
    }
}
