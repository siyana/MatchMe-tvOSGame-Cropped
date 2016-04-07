//
//  NSUserDefaultsManager.h
//  MatchMe
//
//  Created by Siyana Slavova on 2/22/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaultsManager : NSObject

+ (NSUserDefaults *)standardUserDefaults;

+ (void)saveUserName:(NSString*)userName;
+ (void)saveUserScoreIfNeeded:(NSTimeInterval)userTimeScore levelMode:(LevelMode)levelMode;

+ (NSString *)currentUserName;
+ (NSDictionary *)currentBestScoreDictionaryForLevelMode:(LevelMode)levelMode;

@end
