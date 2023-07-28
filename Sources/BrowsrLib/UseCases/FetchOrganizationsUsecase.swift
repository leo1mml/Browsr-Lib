import Combine
import Foundation

public protocol FetchOrganizationsUsecase {
    func publisher(for request: URLRequest) -> AnyPublisher<([Organization], String), Error>
    func publisher(for request: URLRequest) -> AnyPublisher<Organization, Error>
}

public class URLSessionFetchOrganizationsUsecase: FetchOrganizationsUsecase {
    public init() {}
    public func publisher(for request: URLRequest) -> AnyPublisher<([Organization], String), Error> {
        var nextPageURL = ""
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                if let headers = httpResponse.allHeaderFields as? [String: String] {
                    nextPageURL = headers["Link"] ?? ""
                }
                return data
            }
            .decode(type: [Organization].self, decoder: JSONDecoder())
            .map { ($0, nextPageURL) }
            .eraseToAnyPublisher()
    }
    
    public func publisher(for request: URLRequest) -> AnyPublisher<Organization, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: Organization.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
