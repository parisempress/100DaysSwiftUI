//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Rochelle Simone Lawrence on 09.08.24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
