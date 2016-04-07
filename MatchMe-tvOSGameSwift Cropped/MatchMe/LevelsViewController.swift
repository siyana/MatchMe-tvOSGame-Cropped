//
//  LevelsViewController.swift
//  MatchMe
//
//  Created on 10/24/15.
//  Copyright © 2015. All rights reserved.
//

import UIKit

class LevelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: UIFocusEnvironment
    override var preferredFocusedView: UIView? {
        return self.tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 1, inSection: 0))
    }
    
    func indexPathForPreferredFocusedViewInCollectionView(collectionView: UICollectionView) -> NSIndexPath? {
        return NSIndexPath(forRow: 0, inSection: 0)
    }
    
    //MARK: Table View DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Level.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("LevelCellIdentifier", forIndexPath: indexPath) as? LevelTableViewCell else {
            return UITableViewCell()
        }
        switch (Level(rawValue: indexPath.section)!) {
        case .Easy:
          cell.configureWith("1", title: "Fruits & Vegetables",
                            description: "This is easy level, you have to find 4 couples cards among 8 cards of different kinds of fruits and vegetables.",
                             imageNames: ["apple", "strawberry", "carrot"])
        case .Normal:
            cell.configureWith("2", title: "Living Creatures",
                              description: "This is normal level, you have to find 6 couples cards among 12 cards of different kinds of living creatures.",
                               imageNames: ["hp_dog", "bear_mac_archigraphs", "penguin"])
        case .Hard:
            cell.configureWith("3", title: "Mixed",
                              description: "In the hard levels, you have to find 9 couples cards among 18 cards, the level combine previous two and add some traveling options.",
                               imageNames: ["bugatti", "hp_girl", "travel_bus"])
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("GameViewControllerStoryboardID") as! GameViewController
        vc.selectedLevel = Level(rawValue: indexPath.section)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) -> Void {
        // TODO: Task: Improve focus
    }
}