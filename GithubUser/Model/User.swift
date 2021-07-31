//
//  User.swift
//  GithubUser
//
//  Created by Fangwei Hsu on 2021/07/31.
//

import Foundation

struct User: Codable {
    let avatarURLString: String
    let accountName: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURLString = "avatar_url"
        case accountName = "login"
    }
}
