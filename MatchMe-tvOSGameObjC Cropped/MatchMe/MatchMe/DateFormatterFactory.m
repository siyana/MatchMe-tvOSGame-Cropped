//
//  DateFormatterFactory.m
//  MatchMe
//
//  Created by Siyana Slavova on 2/26/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import "DateFormatterFactory.h"

const NSUInteger kCACHE_LIMIT = 15;

@interface DateFormatterFactory ()

@property (strong, nonatomic) NSCache *loadedDataFormatters;
@property (strong, nonatomic) dispatch_queue_t queue;


@end
@implementation DateFormatterFactory

- (id)init {
    self = [super init];
    if (self) {
        self.loadedDataFormatters = [[NSCache alloc] init];
        self.loadedDataFormatters.countLimit = kCACHE_LIMIT;
        self.queue = dispatch_queue_create("com.MobCon.syncQueue_dateFormatterFactory", DISPATCH_QUEUE_SERIAL);;
    }
    return self;
}

+ (DateFormatterFactory *)sharedFactory {
    static DateFormatterFactory *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DateFormatterFactory alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Public interface

- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format {
    return [self dateFormatterWithFormat:format andLocale:[NSLocale currentLocale]];
}


#pragma mark - Utilities

- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format andLocale:(NSLocale *)locale {
    return [self dateFormatterWithFormat:format timeZone:nil];
}

- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timezone {
    __block NSDateFormatter *dateFormatter = nil;
    NSString *key = [NSString stringWithFormat:@"%@|%@|%@", format, [NSLocale currentLocale], timezone.description];
    dispatch_sync(self.queue, ^{
        dateFormatter = [self.loadedDataFormatters objectForKey:key];
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = format;
            dateFormatter.locale = [NSLocale currentLocale];
            dateFormatter.timeZone = timezone;
            [self.loadedDataFormatters setObject:dateFormatter forKey:key];
        }
    });
    
    return dateFormatter;
}


@end
