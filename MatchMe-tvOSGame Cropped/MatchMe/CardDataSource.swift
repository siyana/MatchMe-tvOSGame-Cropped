//
//  CardDataSource.swift
//  MatchMe
//
//  Created on 10/19/15.
//  Copyright © 2015. All rights reserved.
//

import UIKit

class CardDataSource: NSObject {
    
    var cards = [Card]()
    var cardPicturesNames = [String]()
    private var easyLevelImages = [String]()
    private var normalLevelImages = [String]()
    private var hardLevelImages = [String]()

    override init() {
        super.init()
        self.easyLevelImages = ["appleW", "blueberriesW", "carrotW", "lettuceW", "mushroomW", "potatoW", "radishW", "strawberryW", "sugar_snapW", "tomatoW"]
        self.normalLevelImages = ["1_fishW", "antW", "bear_mac_archigraphsW", "dragon_flyW", "elephantW", "hp_boyW", "hp_catW", "hp_dogW", "hp_girlW", "ladybugW", "penguinW", "silly_boy_archigraphsW", "turtleW"]
        self.hardLevelImages = ["aeroplaneW", "bugattiW", "busW", "carW", "suitcaseW", "trainW", "travel_busW"]
        
        let cardCount = levelRowNumber*levelColumnNumber
        var finalNames = [String]()
        
        if (cardCount == easyLevelCardCount) {
            finalNames = self.easyLevelImages.shuffle()
        } else if (cardCount == normalLevelCardCount) {
            finalNames = self.normalLevelImages.shuffle()
        } else if (cardCount == hardLevelCardCount) {
            finalNames = self.normalLevelImages + self.hardLevelImages
            finalNames = finalNames.shuffle()
        }
        
        //Double the pictures
        for nameIndex in 0...(cardCount/2 - 1) {
            self.cardPicturesNames.append(finalNames[nameIndex])
            self.cardPicturesNames.append(finalNames[nameIndex])
        }
        
        //Make names images
        self.cardPicturesNames = self.cardPicturesNames.shuffle()
        for var index = self.cardPicturesNames.count - 1; index >= 0; --index {
            if let cardImage = UIImage(named: self.cardPicturesNames[index]) {
                self.cards.append(Card(name: self.cardPicturesNames[index], image: cardImage))
            }
        }
    }

    func cardPictureAtIndex(index: Int) -> Card? {
        if index < 0 || index > self.cards.count {
            return nil
        } else {
            return self.cards[index]
        }
    }
}

extension CardDataSource: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return levelRowNumber
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levelColumnNumber
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CardCellIdentifier", forIndexPath: indexPath) as? CardCollectionViewCell else {
            return UICollectionViewCell()
        }
        let card : Card = self.cardPictureAtIndex(indexPath.row + (levelColumnNumber*indexPath.section))!
        cell.frontImageView.image = card.image
        NSLog ("\(indexPath.row + (levelColumnNumber*indexPath.section))")
        return cell
    }

}

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
