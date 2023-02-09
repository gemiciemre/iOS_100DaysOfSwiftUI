//
//  ContentView.swift
//  Day43-Project9-Drawing
//
//  Created by Emre Gemici on 2.02.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var insetAmount = 50.0
    @State private var rows = 4
    @State private var columns = 4
    
    
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
        
        Checkerboard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)){
                    rows = 8
                    columns = 16
                }
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
