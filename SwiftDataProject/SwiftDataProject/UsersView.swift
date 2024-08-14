//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Rochelle Simone Lawrence on 14.08.24.
//
import SwiftData
import SwiftUI

struct UsersView: View {
    @Query var users: [User]
    var body: some View {
        List(users) { user in
            Text(user.name)
        }
    }

    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User>{ user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
