//
//  UserProfile.swift
//  GithubUser
//
//  Created by Fangwei Hsu on 2021/07/31.
//

import Foundation

struct UserProfile: Codable {
    let accountName: String
    let avatarURLString: String
    let fullName: String
    let followingCount: Int
    let followerCount: Int
    
    enum CodingKeys: String, CodingKey {
        case accountName = "login"
        case avatarURLString = "avatar_url"
        case fullName = "name"
        case followingCount = "following"
        case followerCount = "followers"
    }
}
