//
//  ContentView.swift
//  FriendFace
//
//  Created by Rochelle Simone Lawrence on 23.08.24.
//

import SwiftUI

struct ContentView: View {
@State private var users = [User]()

    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(value: user) {
                    HStack {
                        Circle()
                            .fill(user.isActive ? .green : .red)
                            .frame(width: 30)
                        Text(user.name)
                    }
                }
            }
            .navigationTitle("Friendface")
            .navigationDestination(for: User.self) { user in
                UserView(user: user)
            }
            .task {
                await fetchUsers()
            }
        }
    }

    func fetchUsers() async {
        guard users.isEmpty else { return }

        do  {
            let url = URL(string: "https://hws.dev/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            users = try decoder.decode([User].self, from: data)
        } catch {
           print("Download failed")
        }
    }
}

#Preview {
    ContentView()
}
