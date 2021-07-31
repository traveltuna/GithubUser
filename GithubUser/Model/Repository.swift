//
//  Repository.swift
//  GithubUser
//
//  Created by Fangwei Hsu on 2021/07/31.
//

import Foundation

struct Repository: Codable {
    let url: String?
    let name: String?
    let descriptionText: String?
    let starCount: Int
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "html_url"
        case name = "name"
        case descriptionText = "description"
        case starCount = "stargazers_count"
        case language = "language"
    }
}
