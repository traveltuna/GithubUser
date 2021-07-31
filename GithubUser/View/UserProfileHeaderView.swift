//
//  UserProfileHeaderView.swift
//  GithubUser
//
//  Created by Fangwei Hsu on 2021/07/31.
//

import UIKit

final class UserProfileHeaderView: UIView {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var followingCountLabel: UILabel!
    @IBOutlet private weak var followerCountLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantiateView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiateView()
    }
    
    func configure(with profile: UserProfile) {
        self.isHidden = false
        avatarImageView.sd_setImage(with: URL(string: profile.avatarURLString)) { [weak self] image, error, _, _ in
            if error != nil {
                self?.avatarImageView.image = UIImage(named: "placeholder")
            } else {
                self?.avatarImageView.image = image
            }
        }
        fullNameLabel.text = profile.fullName
        userNameLabel.text = profile.accountName
        followingCountLabel.text = "\(profile.followingCount)"
        followerCountLabel.text = "\(profile.followerCount)"
    }
}

private extension UserProfileHeaderView {
    func instantiateView() {
        let nib = UINib(nibName: UserProfileHeaderView.className, bundle: .main)
        let rootView = nib.instantiate(withOwner: self).first as! UIView
        rootView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        rootView.frame = self.bounds
        self.addSubview(rootView)
    }
}
