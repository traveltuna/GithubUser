//
//  UserListViewController.swift
//  GithubUser
//
//  Created by Fangwei Hsu on 2021/07/31.
//

import UIKit

final class UserListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    private var userViewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        registerCells()
        fetchUsers()
    }
}

// MARK: Private Methods
private extension UserListViewController {
    func setupAppearance() {
        self.title = "GitHub Users"
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: UserTableViewCell.className, bundle: nil),
                           forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    
    func fetchUsers() {
        userViewModel.fetchUsers { [weak self] viewModel, error in
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
                self?.userViewModel = viewModel
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: UITableViewDataSource Methods
extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier,
                                                      for: indexPath) as! UserTableViewCell
        userCell.configure(with: userViewModel.users[indexPath.row])
        if indexPath.row == userViewModel.users.count - 1 {
            // reach the last row and start to fetch more users
            fetchUsers()
        }
        return userCell
    }
}

// MARK: UITableViewDelegate Methods
extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RepositoryListViewController.instance(with: userViewModel.users[indexPath.row].accountName)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
