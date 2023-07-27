import Foundation

public enum Sources {
    //TODO: Please replace token with one that's yours
    public static var github = BrowsrSource(baseUrl: "api.github.com",
                                            listingPath: "/organizations",
                                            searchPath: "/orgs",
                                            authToken: "")
}
