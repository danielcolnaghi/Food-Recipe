import Foundation

enum APIRouter {
    
    typealias Headers = [String: String?]
    
    case getIngredients
    
    private static let api_key = ""
    
    var scheme: String {
        switch self {
        case .getIngredients:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getIngredients:
            return "run.mocky.io"
        }
    }
    
    private var version: String {
        switch self {
        case .getIngredients:
            return "v3"
        }
    }
    
    var path: String {
        switch self {
        case .getIngredients:
            return "/\(self.version)/45a5a07f-e981-4918-9c31-090b121d6c5f"
        }
    }
    
    var headers: Headers? {
        switch self {
        case .getIngredients:
            return nil
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .getIngredients:
            return nil
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .getIngredients:
            return nil
        }
    }
    
    var method: String {
        switch self {
        case .getIngredients:
            return "GET"
        }
    }
}
