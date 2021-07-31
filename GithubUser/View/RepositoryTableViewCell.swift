//
//  RepositoryTableViewCell.swift
//  GithubUser
//
//  Created by Fangwei Hsu on 2021/07/31.
//

import UIKit

final class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var starLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    
    func configure(with repository: Repository) {
        nameLabel.text = repository.name
        descriptionLabel.text = repository.descriptionText
        starLabel.text = "\(repository.starCount)"
        languageLabel.text = repository.language
    }
}
