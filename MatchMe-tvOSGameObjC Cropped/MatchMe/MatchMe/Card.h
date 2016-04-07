//
//  Card.h
//  MatchMe
//
//  Created by Siyana Slavova on 2/23/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Card : NSObject

@property (strong, nonatomic, readonly) NSString *imageName;
@property (strong, nonatomic, readonly) UIImage *cardImage;

- (instancetype)initWithName:(NSString *)name;

@end
