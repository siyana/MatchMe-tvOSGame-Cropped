//
//  LevelTableViewCell.swift
//  MatchMe
//
//  Created on 10/24/15.
//  Copyright © 2015. All rights reserved.
//

import UIKit

class LevelTableViewCell: UITableViewCell {
    @IBOutlet weak var levelNumberLabel: UILabel!
    @IBOutlet weak var levelTitleLabel: UILabel!
    @IBOutlet weak var levelDescriptionLabel: UILabel!

    @IBOutlet weak var levelImage1: UIImageView!
    @IBOutlet weak var levelImage2: UIImageView!
    @IBOutlet weak var levelImage3: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.borderWidth = 4
        self.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
    override func canBecomeFocused() -> Bool {
        return true
    }
    
    func configureWith(number:String, title:String, description:String, imageNames:[String]) -> Void {
        self.levelNumberLabel.text = number
        self.levelTitleLabel.text = title
        self.levelDescriptionLabel.text = description
        self.levelImage1.image = UIImage(named: imageNames[0])
        self.levelImage2.image = UIImage(named: imageNames[1])
        self.levelImage3.image = UIImage(named: imageNames[2])
    }
    
    func becomeOnFocus(onFocus:Bool) -> Void {
        self.contentView.layer.opacity = onFocus ? 1 : 0.7
        self.levelImage1.hidden = !onFocus
        self.levelImage2.hidden = !onFocus
        self.levelImage3.hidden = !onFocus

    }
}