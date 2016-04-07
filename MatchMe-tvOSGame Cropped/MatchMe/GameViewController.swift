//
//  GameViewController.swift
//  MatchMe
//
//  Created on 10/19/15.
//  Copyright © 2015. All rights reserved.
//
import UIKit
let minCellSpacing : NSInteger! = 20

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var triesCountLabel: UILabel!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!

    internal var cardDataSource : CardDataSource!
    internal var openCardIndexPath : NSIndexPath!
    internal var matchCount : NSInteger! = 0
    internal var triesCount : Double = 0

    var selectedLevel : Level!
    var timer:NSTimer = NSTimer()
    var startTime = NSTimeInterval()

    override func viewDidLoad() {
        super.viewDidLoad()
       // TODO: Task: Create and implement gestures
        self.confugureScreen()
        self.cardDataSource = CardDataSource()
        self.collectionView?.dataSource = self.cardDataSource
        
        if (!timer.valid) {
            let selector : Selector = "updatePlayTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: selector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    
    override var preferredFocusedView: UIView? {
        return self.collectionView
    }
    
    //MARK: Actions
    
    @IBAction func historyTapped(_: AnyObject) {
        var alertController : UIAlertController
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel) {
            (action:UIAlertAction!) in
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        var levelDictionaryKey : String
        switch self.selectedLevel! {
        case .Easy:
            levelDictionaryKey = kEasyLevelKey
        case .Normal:
            levelDictionaryKey = kNormalLevelKey
        case .Hard:
            levelDictionaryKey = kHardLevelKey
        }
        
        if (defaults.dictionaryForKey(levelDictionaryKey) == nil) {
            alertController = UIAlertController(title:"No one finish this game level yet.", message:nil, preferredStyle: .Alert)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion:nil)
        } else {
            let levelInfo : NSDictionary = defaults.dictionaryForKey(levelDictionaryKey)!
            let bestPlayerName : String = levelInfo.valueForKey(kBestPlayerNameKey) as! String
            let bestPlayerScore : Double = levelInfo.valueForKey(kBestPlayerTimeKey) as! Double
            let bestPlayerTries : Double = levelInfo.valueForKey(kBestPlayerTriesKey) as! Double
            let score = String(format: "%.1f", arguments: [bestPlayerScore])
            alertController = UIAlertController(title:"Best score for the level belongs to \(bestPlayerName ?? ""), it is \(score)s. with \(bestPlayerTries) tries.", message: nil, preferredStyle: .Alert)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }
    
    @IBAction func exitTapped(_: AnyObject) {
        self.pauseExitAlert()
    }
    
    
    //MARK: Collection View Delegate
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(self.cellMinHeight()*0.7, self.cellMinHeight())
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        let cellSize = CGSizeMake(self.cellMinHeight()*0.7, self.cellMinHeight())
        return (self.collectionView.frame.size.width - cellSize.width*CGFloat(levelColumnNumber)) / CGFloat(levelColumnNumber)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let cellSize = CGSizeMake(self.cellMinHeight()*0.7, self.cellMinHeight())
        let bottomSize = (self.collectionView.frame.size.height - cellSize.height*CGFloat(levelRowNumber)) / CGFloat(levelColumnNumber - 1)
        return UIEdgeInsets(top: 0, left: 0, bottom: (section == levelRowNumber) ? 0 : bottomSize, right: 0)
    }
 
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) -> Void {
        guard let currentCell = self.collectionView.cellForItemAtIndexPath(indexPath) as? CardCollectionViewCell else {
            return
        }
        if (!currentCell.showingBack) {
            return
        }
        
        if (self.openCardIndexPath == nil) {
            self.triesCount = self.triesCount + 1
            self.triesCountLabel.text =  String(format: "Tries: %.0f", arguments: [self.triesCount])
            
            currentCell.flip()
            self.openCardIndexPath = indexPath
        } else {
            guard let oldCell = self.collectionView.cellForItemAtIndexPath(self.openCardIndexPath) as? CardCollectionViewCell else {
                return
            }
            let openCardName : Card = self.cardDataSource.cards[self.openCardIndexPath.row + (levelColumnNumber*self.openCardIndexPath.section)] as Card
            let newCardName : Card = self.cardDataSource.cards[indexPath.row + (levelColumnNumber*indexPath.section)] as Card
            self.openCardIndexPath = indexPath

            if (openCardName.name == newCardName.name) {
                currentCell.flip()
                self.matchCount = self.matchCount + 1
                if (self.matchCount == (levelRowNumber*levelColumnNumber)/2) {
                    self.checkUserResult()
                }
                self.openCardIndexPath = nil
            } else {
                currentCell.flip()
                self.collectionView.userInteractionEnabled = false
                let delay = 0.3 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) {
                    oldCell.flip()
                    currentCell.flip()
                    self.openCardIndexPath = nil
                    self.collectionView.userInteractionEnabled = true
                }
            }
        }
    }
    
    //MARK: End game alerts

    func checkUserResult() -> Void {
        let newTimeScore : Double = self.timeInseconds() as Double
        self.timer.invalidate()
        self.triesCount = 0
        self.triesCountLabel.text =  String(format: "Tries: %.0f", arguments: [self.triesCount])
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let currentPlayerName : String = defaults.stringForKey(kCurrentUserNameKey)!
        var levelDictionaryKey : String
        switch self.selectedLevel! {
        case .Easy:
            levelDictionaryKey = kEasyLevelKey
        case .Normal:
            levelDictionaryKey = kNormalLevelKey
        case .Hard:
            levelDictionaryKey = kHardLevelKey
        }

        if (defaults.dictionaryForKey(levelDictionaryKey) == nil) {
            //Firts player for the level
            self.showAlert("Congrats, you are the first palyer.", message:"")
            let dicInfo: Dictionary<String,AnyObject> = [kBestPlayerNameKey : currentPlayerName, kBestPlayerTimeKey : newTimeScore, kBestPlayerTriesKey : triesCount]
            defaults.setObject(dicInfo, forKey: levelDictionaryKey)
            return;
        }
        let levelInfo : NSDictionary = defaults.dictionaryForKey(levelDictionaryKey)!
        let bestPlayerScore : Double = levelInfo.valueForKey(kBestPlayerTimeKey) as! Double
        let bestPlayerTries : Double = levelInfo.valueForKey(kBestPlayerTriesKey) as! Double

        if ((self.triesCount < bestPlayerTries) || (self.triesCount == bestPlayerTries && newTimeScore > bestPlayerScore)) {
            defaults.setObject(currentPlayerName ?? "", forKey: kBestPlayerNameKey)
            defaults.setObject(newTimeScore, forKey: kBestPlayerTimeKey)
            defaults.setObject(self.triesCount, forKey: kBestPlayerTriesKey)
            self.showAlert("Congrats!", message: "\(currentPlayerName ?? ""), you are new best player in this game level.")
        } else {
            self.showAlert("Sorry!", message: "\(currentPlayerName ?? ""), your score is not good enought.")
        }
        defaults.synchronize()
    }
    
    
    func showAlert(title: String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel) {
            (action:UIAlertAction!) in
        }
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion:nil)
    }

    //MARK: Utilities
    //MARK: Configure
    
    func pauseExitAlert() -> Void {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .Alert)
        
        let mainScreenAction = UIAlertAction(title: "Main Screen", style: .Default) {
            (action:UIAlertAction!) in print("You have pressed Main Screen button");
            self.navigationController!.popToRootViewControllerAnimated(true)
        }
        alertController.addAction(mainScreenAction)
        
        let levelsScreenAction = UIAlertAction(title: "Levels Screen", style: .Default) {
            (action:UIAlertAction!) in print("You have pressed Levels Screen button");
            self.navigationController!.popViewControllerAnimated(true)
        }
        alertController.addAction(levelsScreenAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {
            (action:UIAlertAction!) in print("you have pressed the Cancel button");
        }
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion:nil)
    }

    func confugureScreen() -> Void {
        switch self.selectedLevel! {
        case .Easy:
            levelRowNumber = 2
            levelColumnNumber = 4
            self.titleLabel.text = "Level 1"
        case .Normal:
            levelRowNumber = 3
            levelColumnNumber = 4
            self.titleLabel.text = "Level 2"
        case .Hard:
            levelRowNumber = 3
            levelColumnNumber = 6
            self.titleLabel.text = "Level 3"
        }
    }
    
    func cellMinHeight() -> CGFloat {
        return CGFloat((CGFloat(self.collectionView.frame.size.height - CGFloat(minCellSpacing*maxRowsCount*2)))/CGFloat(maxRowsCount))
    }
    func updatePlayTime() -> Void {
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = NSDate.timeIntervalSinceReferenceDate() - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        self.timerLabel.text = "\(strMinutes):\(strSeconds)"
    }
    
    func timeInseconds() -> Double {
        var elapsedTime: NSTimeInterval = NSDate.timeIntervalSinceReferenceDate() - startTime
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        return NSTimeInterval(elapsedTime)
    }
}

