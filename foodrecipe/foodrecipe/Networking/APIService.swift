import Foundation
import Alamofire

class APIService {
    
    func request<T: Decodable>(router: APIRouter, result: @escaping (Result<T, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        if let headers = router.headers {
            for item in headers {
                urlRequest.setValue(item.value, forHTTPHeaderField: item.key)
            }
        }
            
        if let httpBody = router.httpBody {
            urlRequest.httpBody = httpBody
        }

        AF.request(urlRequest)
            .validate()
            .responseDecodable(of: T.self) { response in
            switch response.result {
            case let .success(model):
                debugPrint("Validation Successful")
                result(.success(model))
            case let .failure(error):
                debugPrint(error)
                result(.failure(error))
            }
        }
    }
}
