//
//  ContentView.swift
//  Day43-Project9-Drawing
//
//  Created by Emre Gemici on 2.02.2023.
//

import SwiftUI

struct Trapezoid: Shape{
    var insetAmount : Double
    var animatableData: Double{
        get{insetAmount}
        set{insetAmount = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
            path.move(to: CGPoint(x: 0, y: rect.maxY))
            path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX-insetAmount, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        return path
    }
}
//-----------------------------


struct Checkerboard : Shape{
    var rows : Int
    var columns : Int
    var animatableData: AnimatablePair<Double, Double> {
    get {
           AnimatablePair(Double(rows), Double(columns))
        }

    set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowsize = rect.height / Double(rows)
        let columnsize = rect.width / Double(columns)
        
        for row in 0..<rows{
            for column in 0..<columns{
                if(row + column).isMultiple(of: 2){
                    let startX = columnsize * Double(column)
                    let startY = rowsize * Double(row)
                    let rect = CGRect(x: startX, y: startY, width: columnsize, height: rowsize)
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}
//----------------------------


struct Spirograph: Shape{
    
    let innerRadius: Int
    let outerRadius: Int
    let distance : Int
    let amount : Double
    
    func gcd(_ a: Int, _ b: Int)->Int{
        var a = a
        var b = b
        
        while b != 0{
            let temp = b
            b = a%b
            a = temp
        }
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius-outerRadius
        let endPoint = ceil(2*Double.pi*outerRadius / Double(divisor)) * amount
        
        var path = Path()
        
        for theta in stride(from: 0, through: endPoint, by: 0.01){
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width / 2
            y += rect.height / 2
            
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            }
            else{
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        return path
    }
}
    
//---------------------------
    

struct Arrow : Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint)
    }
}






struct ContentView: View {
    
    @State private var amount = 0.0
    @State private var insetAmount = 50.0
    @State private var rows = 4
    @State private var columns = 4
    
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amountSpirograph = 1.0
    @State private var hue = 0.6
    
 
    
    var body: some View {
//  Speacial Effects:blurs, blending
//        VStack{
//            ZStack{
//                Circle()
//                    .fill(.red)
//                    .frame(width:200 * amount)
//                    .offset(x:-50,y:-80)
//                    .blendMode(.screen)
//                Circle()
//                    .fill(.green)
//                    .frame(width:200 * amount)
//                    .offset(x:50,y:-80)
//                    .blendMode(.screen)
//                Circle()
//                    .fill(.blue)
//                    .frame(width:200 * amount)
//                    .blendMode(.screen)
//            }
//            .frame(width: 300,height: 300)
//
//            Slider(value: $amount)
//                .padding()
//        }
//        .frame(maxWidth: .infinity,maxHeight: .infinity)
//        .background(.black)
//        .ignoresSafeArea()
      

//        Trapezoid(insetAmount: insetAmount)
//            .frame(width: 200,height: 100)
//            .onTapGesture {
//                withAnimation{
//                    insetAmount = Double.random(in: 10...90)
//                }
//            }
        
//        Checkerboard(rows: rows, columns: columns)
//            .onTapGesture {
//                withAnimation(.linear(duration: 3)){
//                    rows = 8
//                    columns = 16
//                }
//            }
        
//        VStack{
//            Spacer()
//
//            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amountSpirograph)
//                .stroke(Color(hue: hue, saturation: 1, brightness: 1),lineWidth: 1)
//                .frame(width: 300,height: 300)
//
//            Spacer()
//
//            Group{
//                Text("Inner Radius: \(Int(innerRadius))")
//                Slider(value: $innerRadius, in: 10...150, step: 1)
//                    .padding([.horizontal,.bottom])
//
//                Text("Outer Radius: \(Int(outerRadius))")
//                Slider(value: $outerRadius, in: 10...150, step: 1)
//                    .padding([.horizontal,.bottom])
//
//                Text("Distance: \(Int(distance))")
//                Slider(value:$distance, in: 1...150, step: 1)
//                    .padding([.horizontal,.bottom])
//
//                Text("Amount: \(amountSpirograph, format: .number.precision(.fractionLength(2)))")
//                Slider(value: $amountSpirograph)
//                    .padding([.horizontal,.bottom])
//
//                Text("Color")
//                Slider(value: $hue)
//                    .padding(.horizontal)
//            }
//        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
