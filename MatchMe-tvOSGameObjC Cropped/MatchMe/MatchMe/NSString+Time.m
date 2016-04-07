//
//  NSString+Time.m
//  MatchMe
//
//  Created by Siyana Slavova on 2/26/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import "NSString+Time.h"
#import "DateFormatterFactory.h"

@implementation NSString (Time)

- (NSInteger)toTimeSeconds
{
    NSTimeInterval timeInterval = [[self dateFromString ] timeIntervalSince1970];
    return timeInterval;
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval
{
    if (timeInterval <= 0) {
        timeInterval = 0;
    }
    
    NSDateFormatter *dateFormatter = [[DateFormatterFactory sharedFactory] dateFormatterWithFormat:@"mm:ss"
                                                                                            timeZone:[NSTimeZone localTimeZone]];
    
    NSDate *capturedStartDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [dateFormatter stringFromDate:capturedStartDate];
}

- (NSDate *)dateFromString
{
    NSDateFormatter *dateFormatter = [[DateFormatterFactory sharedFactory] dateFormatterWithFormat:@"mm:ss"
                                                                                            timeZone:[NSTimeZone localTimeZone]];
    
    NSDate *capturedStartDate = [dateFormatter dateFromString:self];
    return capturedStartDate;
}


@end
