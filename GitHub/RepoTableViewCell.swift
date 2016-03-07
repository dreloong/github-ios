//
//  RepoTableViewCell.swift
//  GitHub
//
//  Created by Xiaofei Long on 3/7/16.
//  Copyright © 2016 dreloong. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!

    var repo: Repo! {
        didSet {
            repoNameLabel.text = repo.name
            ownerNameLabel.text = repo.ownerHandle
            descriptionLabel.sizeToFit()
            descriptionLabel.text = repo.repoDescription
            starsCountLabel.text = "Stars: \(repo.starsCount!)"
            forksCountLabel.text = "Forks: \(repo.forksCount!)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
