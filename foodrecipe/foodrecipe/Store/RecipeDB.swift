import Foundation

class RecipeDB {
    static let shared = RecipeDB()
    
    private init(){}
    
    func loadData() -> [Recipe]? {
        guard let path = Bundle.main.path(forResource: "Recipes.json", ofType: nil),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return nil}
        
        return try? JSONDecoder().decode([Recipe].self, from: jsonData)
    }
}
