import UIKit

enum ErrorMessege :Error {
    case outOfBound,falseType
}


func sqrtCalculate(_ num : Int) throws->Int{
    if  num < 1{
        print("Out of the bounds")
        throw ErrorMessege.outOfBound
    }
    else if num > 10_000{
        throw ErrorMessege.outOfBound
    }
    else if num is Int{
        return num * num
    }
    else{
        throw ErrorMessege.falseType
    }
}
do{
    try sqrtCalculate(12)
}
catch ErrorMessege.outOfBound{
    print("Out of the bounds")
    }
catch ErrorMessege.falseType{
    print("No macthes with type")
}

    

