//
//  Card.m
//  MatchMe
//
//  Created by Siyana Slavova on 2/23/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import "Card.h"

@interface Card ()

@property (strong, nonatomic, readwrite) NSString *imageName;
@property (strong, nonatomic, readwrite) UIImage *cardImage;

@end

@implementation Card

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.imageName = name;
        self.cardImage = [UIImage imageNamed:name];
    }
    return self;
}

- (BOOL)isEqual:(Card *)object {
    BOOL result = [self.imageName isEqualToString:object.imageName];
    return result;
}

@end
