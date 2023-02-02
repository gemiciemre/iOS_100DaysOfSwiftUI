//
//  ContentView.swift
//  Day39-Moonshot-Project8
//
//  Created by Emre Gemici on 12.12.2022.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let colomns = [
        GridItem(.adaptive(minimum: 150))
    ]

    @State var toggleIsList : Bool = false
    
    var body: some View {
            NavigationView{
                if !toggleIsList{
                    ScrollView{
                        LazyVGrid(columns: colomns){
                            ForEach(missions) { mission in
                                NavigationLink{
                                    MissionView(mission: mission, astronauts: astronauts)
                                }label: {
                                    VStack{
                                        Image(mission.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .padding()
                                        VStack{
                                            Text(mission.displayName)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text(mission.formattedLaunchDate)
                                                .font(.caption)
                                                .foregroundColor(.white.opacity(0.5))
                                        }
                                        .padding(.vertical)
                                        .frame(maxWidth:.infinity)
                                        .background(.lighBackground)
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.lighBackground)
                                    )
                                }
                            }
                        }
                        .padding([.horizontal,.bottom])
                    }
                    .navigationTitle("Moonshot")
                    .background(.darkBackground)
                    .preferredColorScheme(.dark)
                    .toolbar{
                        Toggle(
                            isOn: $toggleIsList,
                            label: {
                                Text(toggleIsList ? "List" : "Grid")
                            }
                        )
                        .toggleStyle(SwitchToggleStyle())
                    }
                }
                else{
                    List{
                        ForEach(missions) { mission in
                            VStack{
                                NavigationLink{
                                    MissionView(mission: mission, astronauts: astronauts)
                                }label: {
                                    HStack{
                                        Image(mission.image)
                                            .resizable()
                                            .frame(width: 50,height: 50)
                                            .scaledToFit()
                                        VStack{
                                            Text(mission.displayName)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text(mission.formattedLaunchDate)
                                                .font(.caption)
                                                .foregroundColor(.white.opacity(0.5))
                                        }
                                        
                                    }
                                }
                            }
                        }
                        .listRowBackground(Color.darkBackground.ignoresSafeArea())
                        
                        
                    }
                    .navigationTitle("Moonshot")
                    .background(.darkBackground) // It dosent work
                    .preferredColorScheme(.dark)
                    .toolbar{
                        Toggle(
                            isOn: $toggleIsList,
                            label:{
                                Text(toggleIsList ? "List" : "Grid")
                            }
                        )
                        .toggleStyle(SwitchToggleStyle(tint: .darkBackground))
                    }
                }
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
