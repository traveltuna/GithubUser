//
//  UserTableViewCell.swift
//  GithubUser
//
//  Created by Fangwei Hsu on 2021/07/31.
//

import SDWebImage
import UIKit

final class UserTableViewCell: UITableViewCell {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userAccountLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }
    
    func setUser(_ user: User) {
        avatarImageView.sd_setImage(with: URL(string: user.avatarURLString)) { [weak self] image, error, _, _ in
            if error != nil {
                self?.avatarImageView.image = UIImage(named: "placeholder")
            } else {
                self?.avatarImageView.image = image
            }
        }
        userAccountLabel.text = user.accountName
    }
}
