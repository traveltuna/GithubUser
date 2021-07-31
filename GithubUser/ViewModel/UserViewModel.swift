//
//  UserViewModel.swift
//  GithubUser
//
//  Created by Fangwei Hsu on 2021/07/31.
//

import Foundation

struct UserViewModel {
    var users = [User]()
    
    func fetchUsers(completionHandler: @escaping (UserViewModel?, Error?) -> Void) {
        let url = URL(string: "https://api.github.com/users")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            if let data = data,
               let array = try? JSONDecoder().decode([User].self, from: data) {
                completionHandler(UserViewModel(users: array), nil)
            }
        })
        task.resume()
    }
}
