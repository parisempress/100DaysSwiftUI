//
//  Friend.swift
//  FriendFace
//
//  Created by Rochelle Simone Lawrence on 23.08.24.
//

import Foundation

struct Friend: Hashable, Identifiable, Codable {
    let id: UUID
    var name: String
}
