import XCTest
@testable import BrowsrLib
import Combine

class MockOrganizationsUseCase: FetchOrganizationsUsecase {
    var singleResult: Result<Organization, Error>?
    func publisher(for request: URLRequest) -> AnyPublisher<Organization, Error> {
        guard let result = singleResult else {
            return Fail(error: URLError(.dataNotAllowed)).eraseToAnyPublisher()
        }
        return result.publisher.eraseToAnyPublisher()
    }
    
    var result: Result<([Organization], String), Error>?
    func publisher(for request: URLRequest) -> AnyPublisher<([Organization], String), Error> {
        guard let result = result else {
            return Fail(error: URLError(.dataNotAllowed)).eraseToAnyPublisher()
        }
        
        return result.publisher.eraseToAnyPublisher()
    }
}

final class BrowsrLibTests: XCTestCase {

    private var sut: BrowsrLib!
    private var source: BrowsrSource!
    private var requestMaker: RequestMaker!
    private var organizationsUseCase: MockOrganizationsUseCase!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        source = BrowsrSource(baseUrl: "test.com",
                              listingPath: "/mydata",
                              searchPath: "/mysearch",
                              authToken: "aoeuaoeuaouhr298349")
        requestMaker = GithubRequestMaker(source: source)
        organizationsUseCase = MockOrganizationsUseCase()
        sut = BrowsrLib(requestMaker: requestMaker,
                        organizationsUseCase: organizationsUseCase)
    }
    
    func testGetOrganizations_retrievesData() {
        let expectation = expectation(description: "fetches data")
        var error: Error?
        var endResult: [Organization] = []
        let org = Organization(login: "user",
                               id: 12341239,
                               url: "www.test.com",
                               avatarURL: "www.avatar.com",
                               description: "aoecuh 'r,.ch'r aonetuha")
        organizationsUseCase.result = .success(([org], ""))
        sut.getOrganizations(page: 1)
            .sink { completion in
                switch completion {
                case .finished:
                    break;
                case .failure(let e):
                    error = e
                }
                expectation.fulfill()
            } receiveValue: { organizations in
                endResult = organizations.0
            }.store(in: &cancellables)
        wait(for: [expectation], timeout: 2)
        XCTAssert(!endResult.isEmpty)
        XCTAssertNil(error)
    }
    
    func testGetOrganizations_forwardsError() {
        let expectation = expectation(description: "fetches data")
        var error: Error?
        var endResult: [Organization] = []
        organizationsUseCase.result = .failure(URLError(.cannotLoadFromNetwork))
        sut.getOrganizations(page: 1)
            .sink { completion in
                switch completion {
                case .finished:
                    break;
                case .failure(let e):
                    error = e
                }
                expectation.fulfill()
            } receiveValue: { organizations in
                endResult = organizations.0
            }.store(in: &cancellables)
        wait(for: [expectation], timeout: 2)
        XCTAssert(endResult.isEmpty)
        XCTAssertNotNil(error)
    }
    
    func testGetOrganizations_checksForValidURL() {
        let expectation = expectation(description: "fetches data")
        var error: Error?
        var endResult: [Organization] = []
        source = BrowsrSource(baseUrl: "aroeu @ h2com",
                              listingPath: "/mydata",
                              searchPath: "/mysearch",
                              authToken: "aoeuaoeuaouhr298349")
        requestMaker = GithubRequestMaker(source: source)
        organizationsUseCase = MockOrganizationsUseCase()
        sut = BrowsrLib(requestMaker: requestMaker,
                        organizationsUseCase: organizationsUseCase)
        
        organizationsUseCase.result = .failure(URLError(.cannotLoadFromNetwork))
        sut.getOrganizations(page: 1)
            .sink { completion in
                switch completion {
                case .finished:
                    break;
                case .failure(let e):
                    error = e
                }
                expectation.fulfill()
            } receiveValue: { organizations in
                endResult = organizations.0
            }.store(in: &cancellables)
        wait(for: [expectation], timeout: 2)
        XCTAssert(endResult.isEmpty)
        XCTAssertNotNil(error)
    }
}
