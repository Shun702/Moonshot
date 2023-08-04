//
//  MissionView.swift
//  Moonshot
//
//  Created by Shun Le Yi Mon on 31/07/2023.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let crew: [CrewMember]
    
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    Text(mission.formattedLaunchDate)
                    VStack(alignment: .leading) {
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        CrewView(mission: mission, astronauts: astronauts)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
