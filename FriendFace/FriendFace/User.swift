//
//  User.swift
//  FriendFace
//
//  Created by Rochelle Simone Lawrence on 23.08.24.
//

import Foundation

struct User: Hashable, Identifiable, Codable {
    let id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]

    static let example = User(id: UUID(), isActive: true, name: "Tom", age: 21, company: "Sample", email: "sample@de.com", address: "15 Marsch Road", about:" Engineer", registered: .now, tags: ["swift", "swiftui", "cat"], friends: [])

}
