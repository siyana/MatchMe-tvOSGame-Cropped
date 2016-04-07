//
//  NSUserDefaultsManager.m
//  MatchMe
//
//  Created by Siyana Slavova on 2/22/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import "NSUserDefaultsManager.h"

@implementation NSUserDefaultsManager

+ (NSUserDefaults *)standardUserDefaults {
    return [NSUserDefaults standardUserDefaults];
}

+ (void)saveUserName:(NSString *)userName {
    if (userName.length == 0) {
        userName = @"No Name";
    }
    
    [[self standardUserDefaults] setObject:userName forKey:kCurrentUserNameKey];
    [[self standardUserDefaults] synchronize];
}

+ (void)saveUserScoreIfNeeded:(NSTimeInterval)userTimeScore levelMode:(LevelMode)levelMode {
    NSNumber *bestTimeScore = [self userTimeScoreForLevel:levelMode];
    
    if (!bestTimeScore || bestTimeScore.doubleValue >= userTimeScore) {
        NSMutableDictionary *newDictionary = [NSMutableDictionary new];
        
        [newDictionary setObject:[self currentUserName] forKey:kBestPlayerNameKey];
        [newDictionary setObject:@(userTimeScore) forKey:kBestPlayerTimeKey];
        
        [[self standardUserDefaults] setObject:newDictionary
                                        forKey:[self keyForLevelMode:levelMode]];
        
        [[self standardUserDefaults] synchronize];
    }
}

+ (NSDictionary *)currentBestScoreDictionaryForLevelMode:(LevelMode)levelMode {
    NSDictionary *bestScoreDict = nil;
    bestScoreDict = [[self standardUserDefaults] valueForKey:[self keyForLevelMode:levelMode]];
    return bestScoreDict;
}

+ (NSString *)currentUserName {
    return [[self standardUserDefaults] objectForKey:kCurrentUserNameKey];
}

+ (NSNumber *)userTimeScoreForLevel:(LevelMode)levelMode {
    NSDictionary *bestScoreDictionary = [self currentBestScoreDictionaryForLevelMode:levelMode];
    NSNumber *timeScore = nil;
    if (bestScoreDictionary) {
        timeScore = [bestScoreDictionary objectForKey:kBestPlayerTimeKey];
    }
    return timeScore;
}

+ (NSString *)keyForLevelMode:(LevelMode)levelMode {
    NSString *key = @"";
    switch (levelMode) {
        case LevelModeEasy:
            key = kEasyLevelKey;
            break;
        case LevelModeNormal:
            key = kNormalLevelKey;
            break;
        case LevelModeHard:
            key = kHardLevelKey;
            break;
        default:
            break;
    }
    return key;
}

@end
