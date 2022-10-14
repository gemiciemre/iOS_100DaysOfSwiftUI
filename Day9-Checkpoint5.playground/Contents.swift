import UIKit


let luckyNumbers = [7,4,38,21,16,15,12,33,31,49]
let sortedArray = luckyNumbers.sorted()
let evenArray = sortedArray.filter{!$0.isMultiple(of: 2)}
evenArray.map {print("\($0) is a lucky number")}




