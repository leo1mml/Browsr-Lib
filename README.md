# BrowsrLib

This library's purpose is to make it easier to see github organizations on your cellphone.

## Usage
There are two main functions for it

* Retrieve a collection of organizations
* Retrieve a single organization from a search query

If you also need a token you can create a custom source to consume the api with you benefits

Ex:

```Swift
BrowsrSource(baseUrl: "api.github.com",
        listingPath: "/organizations",
        searchPath: "/orgs",
        authToken: "{yourToken}")
```
This way you'll be able to use even other plataforms using the same data structures, all you have to do is setup you source and inject it.
