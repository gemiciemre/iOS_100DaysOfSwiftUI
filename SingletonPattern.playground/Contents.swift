//import UIKit

class Car{

    // create a singleton
    static let carObj = Car()

    // create a private initializer
    private init() {
  
    }

    // method to define car model
    func carModel(car: String) {

        // func code
        print("Your car model is \(car)")
    
        }
}

    let carModel = "GMC"

    // access method
    let carSample = Car.carObj
    carSample.carModel(car: carModel)

    // by EmreGEMICI
