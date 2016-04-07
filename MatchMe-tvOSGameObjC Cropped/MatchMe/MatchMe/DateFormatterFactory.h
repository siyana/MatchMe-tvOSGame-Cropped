//
//  DateFormatterFactory.h
//  MatchMe
//
//  Created by Siyana Slavova on 2/26/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatterFactory : NSObject

+ (DateFormatterFactory *)sharedFactory;

- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format;
- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timezone;

@end
