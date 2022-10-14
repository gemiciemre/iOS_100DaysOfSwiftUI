import UIKit

func optionalArray(_ input: [Int]?) -> Int? {
    let array : [Int]? = input
    return array?.randomElement() ?? Int.random(in: 1...100)
}



