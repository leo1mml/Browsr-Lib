import Foundation

public protocol RequestMaker {
    func makeFetchOrganizations() -> Result<URLRequest, Error>
}
