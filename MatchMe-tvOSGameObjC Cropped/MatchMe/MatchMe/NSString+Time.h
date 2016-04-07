//
//  NSString+Time.h
//  MatchMe
//
//  Created by Siyana Slavova on 2/26/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Time)

- (NSInteger)toTimeSeconds;

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval;

@end
