//
//  Configurations.m
//  MatchMe
//
//  Created by Siyana Slavova on 2/22/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import "Configurations.h"

@implementation Configurations

NSInteger const maxRowsCount = 3;
NSInteger const maxColumnCount = 6;

NSInteger const easyLevelCardCount = 8;
NSInteger const normalLevelCardCount = 12;
NSInteger const hardLevelCardCount = 18;

NSString* const kCurrentUserNameKey = @"CurrentUserNameKey";
NSString* const kBestPlayerNameKey = @"BestPlayerNameKey";
NSString* const kBestPlayerTimeKey = @"BestPlayerTimeKey";
NSString* const kBestPlayerTriesKey = @"BestPlayerTriesKey";

NSString* const kEasyLevelKey = @"EasyLevelKey";
NSString* const kNormalLevelKey = @"NormalLevelKey";
NSString* const kHardLevelKey = @"HardLevelKey";

+ (NSString *)nameForLevelMode:(LevelMode)levelMode {
    NSString *result = @"";
    switch (levelMode) {
        case LevelModeEasy: {
            result = @"easy level";
            break;
        }
        case LevelModeNormal: {
            result = @"normal level";
            break;
        }
        case LevelModeHard: {
            result = @"hard level";
            break;
        }
        case LevelsCount: {
            
            break;
        }
    }
    return result;
}

@end
