//
//  UserViewModel.swift
//  GithubUser
//
//  Created by Fangwei Hsu on 2021/07/31.
//

import Foundation

struct UserViewModel {
    var users = [User]()
    var userId = 1
    static let numberPerPage = 30
    
    func fetchUsers(completionHandler: @escaping (UserViewModel?, Error?) -> Void) {
        var components = URLComponents(string: "https://api.github.com/users")!
        components.queryItems = [URLQueryItem(name: "since", value: "\(userId)")]
        let request = URLRequest(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            if let data = data,
               let array = try? JSONDecoder().decode([User].self, from: data) {
                completionHandler(UserViewModel(users: users + array, userId: userId + UserViewModel.numberPerPage), nil)
            }
        })
        task.resume()
    }
}
