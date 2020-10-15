//
//  API.swift
//  MarvelReactive
//
//  Created by Ecko Huynh on 10/14/20.
//

import Foundation
import Combine
protocol API {
    associatedtype RequestPayload: RequestPayloadProtocol
    associatedtype ResponsePayload: ResponsePayloadProtocol
    // TODO: Make NetworkService & Environment
    func response(from request: RequestPayload) -> AnyPublisher<ResponsePayload, APIServiceError>
}

extension API {
    func response(from request: RequestPayload) -> AnyPublisher<ResponsePayload, APIServiceError> {
        let pathURL = URL(string: request.endpoint, relativeTo: URL(string: APIKeys.Marvel)!)!
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        debugPrint("Ecko \(String(describing: request.query)) endpoint \(request.endpoint)")
        urlComponents.queryItems = request.query
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let decorder = JSONDecoder()
        return URLSession.shared.dataTaskPublisher(for: request)
            .map{ data, urlResponse in
                return data
            }
            .mapError { _ in APIServiceError.responseError }
            .decode(type: ResponsePayload.self, decoder: decorder)
            .mapError(APIServiceError.parseError)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

protocol RequestPayloadProtocol {
    var query: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
    var endpoint: String { get }
    var headers: [String: String] { get }
    var params: NetworkBody { get }
}

extension RequestPayloadProtocol {
    var method: HTTPMethod {
        return .get
    }
    var headers: [String: String] {
        return [:]
    }
    
    var query: [URLQueryItem]? {
        return []
    }
    
    var params: NetworkBody {
        return NetworkBody()
    }
}

protocol ResponsePayloadProtocol: Decodable {
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
struct NetworkBody {
    let data: Any?
    
    init() {
        self.data = nil
    }
    
    init(data: Any) {
        self.data = data
    }
}
