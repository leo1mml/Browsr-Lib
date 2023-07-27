import Foundation

public struct BrowsrSource {
    public init(baseUrl: String, listingPath: String, searchPath: String, authToken: String) {
        self.baseUrl = baseUrl
        self.listingPath = listingPath
        self.searchPath = searchPath
        self.authToken = authToken
    }
    
    public let baseUrl: String
    public let listingPath: String
    public let searchPath: String
    public var authToken: String
}
