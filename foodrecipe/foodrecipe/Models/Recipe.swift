import Foundation

struct Recipe: Codable, Equatable {
    var name: String
    var ingredients: [String]

    static func ==(lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.name == rhs.name && lhs.ingredients == rhs.ingredients
    }
}
