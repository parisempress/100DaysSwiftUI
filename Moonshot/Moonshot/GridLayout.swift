//
//  GridLayout.swift
//  Moonshot
//
//  Created by Rochelle Simone Lawrence on 20.06.24.
//

import SwiftUI

struct GridLayout: View {

    let astronauts: [String: Astronaut]
    let missions: [Mission]

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)

                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }

                }

            }
            .padding(([.horizontal, .bottom]))

        }
        .navigationTitle(("Moonshot"))
        .background(.darkBackground)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    GridLayout(astronauts: Bundle.main.decode("astronauts.json"), missions: Bundle.main.decode("missions.json"))
        .preferredColorScheme(.dark)
}
