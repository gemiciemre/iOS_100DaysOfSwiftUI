//
//  MissionView.swift
//  Day39-Moonshot-Project8
//
//  Created by Emre Gemici on 1.02.2023.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember{
        let role: String
        let astronaut:Astronaut
    }
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                VStack{
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth:geometry.size.width * 0.6)
                        .padding(.top)
                    Text("Launch Date : \(mission.formattedLaunchDate)")
                        .foregroundColor(.secondary)
                    
                    VStack(alignment: .leading){
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lighBackground)
                            .padding(.vertical)
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom,5)
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lighBackground)
                            .padding(.vertical)
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom,5)
                    }
                    .padding(.horizontal)

                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                            ForEach(crew, id:\.role) { crewMember in
                                NavigationLink{
                                    AstronautView(astronaut: crewMember.astronaut)
                                }label: {
                                    HStack{
                                        Image(crewMember.astronaut.id)
                                            .resizable()
                                            .frame(width: 104,height: 72)
                                            .clipShape(Capsule())
                                            .overlay(
                                                Capsule()
                                                    .strokeBorder(.white,lineWidth: 1)
                                            )
                                        VStack(alignment:.leading){
                                            Text(crewMember.astronaut.name)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            Text(crewMember.role)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    init(mission:Mission, astronauts:[String:Astronaut]){
        self.mission=mission
        
        self.crew=mission.crew.map{ member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            }
            else{
                fatalError("Missing \(member.name)")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions:[Mission] = Bundle.main.decode("missions.json") // I couldnt get it what to do in here
    static let astronauts:[String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
