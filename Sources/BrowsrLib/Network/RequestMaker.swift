import Foundation

public protocol RequestMaker {
    func makeFetchOrganizations(page: Int) -> Result<URLRequest, Error>
    func makeSearchOrganization(with term: String, page: Int) -> Result<URLRequest, Error>
}
