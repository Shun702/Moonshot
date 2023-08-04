//
//  ContentView.swift
//  Moonshot
//
//  Created by Shun Le Yi Mon on 29/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingGrid = true
    
    var body: some View {
        
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        NavigationView {
            VStack {
                if showingGrid {
                    GridLayout(astronauts: astronauts, mission: missions[0])
                } else {
                    ListLayout(astronauts: astronauts, mission: missions[0])
                }
            }
            //.navigationTitle("Moonshot")
            .toolbar {
                Button("Change View"){
                    showingGrid.toggle()
                }.buttonStyle(.plain)
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
