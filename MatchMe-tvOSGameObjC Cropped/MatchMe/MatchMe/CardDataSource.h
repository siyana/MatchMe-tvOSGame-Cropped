//
//  CardDataSource.h
//  MatchMe
//
//  Created by Siyana Slavova on 2/23/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Card.h"

@interface CardDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, readonly) NSInteger columnsCount;
@property (nonatomic, readonly) NSInteger rowsCount;

- (instancetype)initWithLevelMode:(LevelMode)levelMode;

- (Card *)cardAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)uniqueCardsCount;

@end
