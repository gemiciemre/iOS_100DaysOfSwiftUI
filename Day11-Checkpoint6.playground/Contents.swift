import UIKit


struct Car {
    var carModel : String
    var numSeats : Int
    private var currentGear = 1
    init(carModel:String, numSeats: Int){
        self.carModel = carModel
        self.numSeats = numSeats
        
    }
    mutating func upGear(){
        if currentGear + 1 > 10 {
            print("Your Car's Gear is already on the top!!")
        } else {
            currentGear += 1
            print(currentGear)
        }
    }
    mutating func downGear(){
        if currentGear - 1 < 1 {
                print("Your Car's Gear is in the lowest!!")
        } else {
            currentGear -= 1
            print(currentGear)
        }
    }
}




