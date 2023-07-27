import Foundation

public protocol RequestMaker {
    func makeFetchOrganizations(page: Int) -> Result<URLRequest, Error>
    func makeSearchOrganizations(with term: String, page: Int) -> Result<URLRequest, Error>
}
