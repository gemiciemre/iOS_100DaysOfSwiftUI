//
//  ContentView.swift
//  Day32-Project6-Animations
//
//  Created by Emre Gemici on 4.11.2022.
//

import SwiftUI


struct CornerRotateModifier : ViewModifier{
    let amount: Double
    let anchor: UnitPoint // what does it mean ?
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

struct ContentView: View {
    @State private var isShowingRed = false

    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.blue)
                .frame(width: 200,height: 200)
            if isShowingRed{
                Rectangle()
                    .fill(.red)
                    .frame(width: 200,height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation{
                isShowingRed.toggle()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition{
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}
