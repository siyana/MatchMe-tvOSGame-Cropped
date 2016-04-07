
//
//  CardCollectionViewCell.swift
//  MatchMe
//
//  Created on 10/19/15.
//  Copyright © 2015. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!

    var showingBack = true

    internal func flip() -> Void {
        if (self.showingBack) {
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                self.cardImageView.alpha = 0
                self.frontImageView.alpha = 1
                }, completion: { (Bool) -> Void in
                    self.showingBack = false
            });
        } else {
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                self.cardImageView.alpha = 1
                self.frontImageView.alpha = 0;
                }, completion: { (Bool) -> Void in
                    self.showingBack = true
            });
        }
    }

}
