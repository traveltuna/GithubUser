//
//  RepositoryViewModel.swift
//  GithubUser
//
//  Created by Fangwei Hsu on 2021/07/31.
//

import Foundation

struct RepositoryViewModel {
    var repositories = [Repository]()
    var page = 1
    var shouldStopLoading = false
    
    func fetchRepositories(with username: String, completionHandler: @escaping (RepositoryViewModel?, Error?) -> Void) {
        var components = URLComponents(string: "https://api.github.com/users/" + username + "/repos")!
        components.queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        let request = URLRequest(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            if let data = data,
               let array = try? JSONDecoder().decode([Repository].self, from: data) {
                let notForkRepositories = array.filter { !$0.isFork }
                completionHandler(RepositoryViewModel(repositories: repositories + notForkRepositories,
                                                      page: page + 1,
                                                      shouldStopLoading: array.isEmpty), nil)
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
