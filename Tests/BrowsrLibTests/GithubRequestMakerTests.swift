import XCTest
@testable
import BrowsrLib

class GithubRequestMakerTests: XCTestCase {
    private var sut: GithubRequestMaker!
    private var source: BrowsrSource!
    
    override func setUp() {
        super.setUp()
        source = BrowsrSource(baseUrl: "www.test.com",
                              listingPath: "/list",
                              searchPath: "/search",
                              authToken: "token")
        sut = GithubRequestMaker(source: source)
    }
    
    func testValidSearchURL() {
        let result = sut.makeSearchOrganization(with: "term", page: 1)
        switch result {
        case .success(let request):
            XCTAssertEqual(request.url!.absoluteString, "https://www.test.com/search/term?page=1")
        case .failure(_):
            XCTFail()
        }
    }
}
