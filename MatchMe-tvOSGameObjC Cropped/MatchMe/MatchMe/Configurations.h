//
//  Configurations.h
//  MatchMe
//
//  Created by Siyana Slavova on 2/22/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configurations : NSObject

extern NSInteger const maxRowsCount;
extern NSInteger const maxColumnCount;

extern NSInteger const easyLevelCardCount;
extern NSInteger const normalLevelCardCount;
extern NSInteger const hardLevelCardCount;

typedef NS_ENUM(NSUInteger, LevelMode) {
    LevelModeEasy,
    LevelModeNormal,
    LevelModeHard,
    LevelsCount
};

extern NSString* const kCurrentUserNameKey;
extern NSString* const kBestPlayerNameKey;
extern NSString* const kBestPlayerTimeKey;
extern NSString* const kBestPlayerTriesKey;

extern NSString* const kEasyLevelKey;
extern NSString* const kNormalLevelKey;
extern NSString* const kHardLevelKey;

+ (NSString *)nameForLevelMode:(LevelMode)levelMode;

@end
