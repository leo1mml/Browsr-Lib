//
//  Organization.swift
//  Browsr Lib
//
//  Created by Leonel Lima on 26/07/2023.
//

import Foundation

public struct Organization: Codable {
    public let login: String
    public let id: Int
    public let url: String
    public let avatarURL: String?
    public let description: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case url
        case avatarURL = "avatar_url"
        case description
    }
}
