import UIKit

class Animal {
    var legs : Int
    init(legs : Int){
        self.legs = legs
    }
}
class Dog : Animal{
    func dogSpeak(){
        print("Hav, Hav, Hav...")
    }
}
class Corgi : Dog{
    override func dogSpeak() {
        print("HAAAV HAAAV")
    }
}
class Poodle : Dog{
    override func dogSpeak() {
        print("HAAAAAAAAAAAAV")
    }
}

class Cat : Animal{
    var isTame : Bool
    init(legs: Int,isTame : Bool){
        self.isTame=isTame
        super.init(legs: legs)
    }
    func catSpeak(){
        print("Miyav, Miyav")
    }
}
class Persian : Cat{
    override func catSpeak() {
        print("Miyaaaaaaaav")
    }
}
class Lion : Cat {
    override func catSpeak() {
        print("ARRRRRRRHHHGHG")
    }
}

