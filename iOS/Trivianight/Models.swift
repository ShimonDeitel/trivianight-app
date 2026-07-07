import Foundation

struct NightEntry: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var rating: Int = 3
    var dateAdded: Date = Date()
    var venue: String
    var score: Double
    var placement: Double
    var notes: String

    init(id: UUID = UUID(), title: String, rating: Int = 3, dateAdded: Date = Date(), venue: String = "", score: Double = 0, placement: Double = 0, notes: String = "") {
        self.id = id
        self.title = title
        self.rating = rating
        self.dateAdded = dateAdded
        self.venue = venue
        self.score = score
        self.placement = placement
        self.notes = notes
    }
}
