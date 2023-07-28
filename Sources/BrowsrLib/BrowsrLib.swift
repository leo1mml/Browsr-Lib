// The Swift Programming Language
// https://docs.swift.org/swift-book
import Combine

public class BrowsrLib {
    
    private let requestMaker: RequestMaker
    private let organizationsUseCase: FetchOrganizationsUsecase
    
    public init(requestMaker: RequestMaker = GithubRequestMaker(),
         organizationsUseCase: FetchOrganizationsUsecase = URLSessionFetchOrganizationsUsecase()) {
        self.requestMaker = requestMaker
        self.organizationsUseCase = organizationsUseCase
    }
    
    public func getOrganizations(page: Int) -> AnyPublisher<([Organization], String), Error> {
        switch requestMaker.makeFetchOrganizations(page: page) {
        case .success(let request):
            return organizationsUseCase.publisher(for: request)
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    public func searchOrganization(by term: String, page: Int) -> AnyPublisher<Organization, Error> {
        switch requestMaker.makeSearchOrganization(with: term, page: page) {
        case .success(let request):
            return organizationsUseCase.publisher(for: request)
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
