import Foundation

public protocol RequestMaker {
    func makeFetchOrganizations(customPath: String) -> Result<URLRequest, Error>
    func makeSearchOrganization(with term: String) -> Result<URLRequest, Error>
}
