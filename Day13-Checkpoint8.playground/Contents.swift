import UIKit

protocol Build {
    var roomsCount : Int { get }
    var cost : Int {get}
    var name : String {get}
}

struct House : Build{
    var cost: Int
    var name: String
    var roomsCount: Int

}
struct Office : Build{
    var roomsCount: Int
    var cost: Int
    var name: String 
}
