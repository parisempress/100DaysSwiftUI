import Foundation

struct Activity: Equatable, Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var completionCount = 0

    static let example = Activity(title: "Example activity", description: "This is a test activity")
}
