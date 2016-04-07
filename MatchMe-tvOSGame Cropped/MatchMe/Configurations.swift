//
//  Configurations.swift
//  MatchMe
//
//  Copyright © 2015. All rights reserved.
//

import UIKit

let levelsNumber : NSInteger! = 3
var levelRowNumber : NSInteger!
var levelColumnNumber : NSInteger!

let maxRowsCount : NSInteger! = 3
let maxColumnCount : NSInteger! = 6

var easyLevelCardCount : NSInteger! = 8
let normalLevelCardCount : NSInteger! = 12
let hardLevelCardCount : NSInteger! = 18

enum Level: Int {
    case Easy
    case Normal
    case Hard
    static var count: Int {
        return Level.Hard.hashValue + 1
    }
}

struct Card {
    var name : String
    var image : UIImage
}

let kCurrentUserNameKey : String! = "CurrentUserNameKey"
let kBestPlayerNameKey : String! = "BestPlayerNameKey"
let kBestPlayerTimeKey : String! = "BestPlayerTimeKey"
let kBestPlayerTriesKey : String! = "BestPlayerTriesKey"

let kEasyLevelKey : String! = "EasyLevelKey"
let kNormalLevelKey : String! = "NormalLevelKey"
let kHardLevelKey : String! = "HardLevelKey"
