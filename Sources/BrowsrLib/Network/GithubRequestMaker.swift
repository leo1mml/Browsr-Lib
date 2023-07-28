import Foundation

public class GithubRequestMaker: RequestMaker {
    
    private let source: BrowsrSource
    
    public init(source: BrowsrSource = Sources.github) {
        self.source = source
    }
    
    public func makeFetchOrganizations(customPath: String) -> Result<URLRequest, Error> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = source.baseUrl
        components.path = source.listingPath
        components.query = customPath
        guard let url = components.url else {
            return .failure(URLError(.badURL))
        }
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/vnd.github+json",
            "Authorization": source.authToken
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return .success(request)
    }
    
    public func makeSearchOrganization(with term: String) -> Result<URLRequest, Error> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = source.baseUrl
        components.path = source.searchPath + "/\(term)"
        
        guard let url = components.url else {
            return .failure(URLError(.badURL))
        }
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/vnd.github+json",
            "Authorization": source.authToken
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return .success(request)
    }
}
