//
//  RepositoryListViewController.swift
//  GithubUser
//
//  Created by Fangwei Hsu on 2021/07/31.
//

import UIKit

final class RepositoryListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet private weak var profileHeaderView: UserProfileHeaderView!
    
    private var userName: String!
    private var repositoryViewModel = RepositoryViewModel()
    
    static func instance(with userName: String) -> RepositoryListViewController {
        let storyboard = UIStoryboard(name: "RepositoryList", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! RepositoryListViewController
        vc.userName = userName
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        registerCells()
        fetchRepositories()
        fetchUserProfile()
    }
}

// MARK: Private Methods
private extension RepositoryListViewController {
    func setupAppearance() {
        self.title = userName
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: RepositoryTableViewCell.className, bundle: nil),
                           forCellReuseIdentifier: RepositoryTableViewCell.identifier)
    }
    
    func fetchRepositories() {
        repositoryViewModel.fetchRepositories(with: userName) { [weak self] viewModel, error in
            if let error = error {
                let alert = UIAlertController(title: "Error",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(cancelAction)
                DispatchQueue.main.async {
                    self?.present(alert, animated: true, completion: nil)
                }
            } else if let viewModel = viewModel {
                self?.repositoryViewModel = viewModel
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func fetchUserProfile() {
        repositoryViewModel.fetchUserProfile(with: userName) { [weak self] profile, error in
            if let error = error {
                let alert = UIAlertController(title: "Error",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(cancelAction)
                DispatchQueue.main.async {
                    self?.present(alert, animated: true, completion: nil)
                }
            } else if let profile = profile {
                DispatchQueue.main.async {
                    self?.profileHeaderView.configure(with: profile)
                }
            }
        }
    }
}

// MARK: UITableViewDataSource Methods
extension RepositoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryViewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier,
                                                      for: indexPath) as! RepositoryTableViewCell
        cell.configure(with: repositoryViewModel.repositories[indexPath.row])
        if indexPath.row == repositoryViewModel.repositories.count - 1 {
            // reach the last row and start to fetch more repositories
            fetchRepositories()
        }
        return cell
    }
}

// MARK: UITableViewDelegate Methods
extension RepositoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BrowserViewController.instance(with: repositoryViewModel.repositories[indexPath.row].url)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
