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
//            if let returnData = String(data: data!, encoding: .utf8) {
//                print(returnData)
//            }
            if let data = data,
               let array = try? JSONDecoder().decode([Repository].self, from: data) {
                completionHandler(RepositoryViewModel(repositories: array), nil)
            }
        })
        task.resume()
    }
}
