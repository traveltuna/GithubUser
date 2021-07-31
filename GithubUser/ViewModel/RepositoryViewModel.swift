//
//  RepositoryViewModel.swift
//  GithubUser
//
//  Created by Fangwei Hsu on 2021/07/31.
//

import Foundation

struct RepositoryViewModel {
    var repositories = [Repository]()
    
    func fetchRepositories(with username: String, completionHandler: @escaping (RepositoryViewModel?, Error?) -> Void) {
        let url = URL(string: "https://api.github.com/users/" + username + "/repos")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            if let data = data,
               let array = try? JSONDecoder().decode([Repository].self, from: data) {
                let notForkRepositories = array.filter { !$0.isFork }
                print(notForkRepositories.count)
                print(array.count)
                completionHandler(RepositoryViewModel(repositories: array), nil)
            }
        })
        task.resume()
    }
    
    func fetchUserProfile(with username: String, completionHandler: @escaping (UserProfile?, Error?) -> Void) {
        let url = URL(string: "https://api.github.com/users/" + username)!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            if let data = data,
               let profile = try? JSONDecoder().decode(UserProfile.self, from: data) {
                completionHandler(profile, nil)
            }
        })
        task.resume()
    }
}
