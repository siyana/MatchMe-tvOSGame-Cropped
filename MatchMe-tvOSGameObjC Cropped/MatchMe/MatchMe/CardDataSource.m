//
//  CardDataSource.m
//  MatchMe
//
//  Created by Siyana Slavova on 2/23/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import "CardDataSource.h"

#import "CardCollectionViewCell.h"

#import "NSMutableArray+Shuffle.h"


@interface CardDataSource ()

@property (strong, nonatomic) NSMutableArray *cards;

@property (nonatomic) LevelMode levelMode;

@property (nonatomic, readwrite) NSInteger columnsCount;
@property (nonatomic, readwrite) NSInteger rowsCount;

@end

@implementation CardDataSource

- (instancetype)initWithLevelMode:(LevelMode)levelMode {
    self = [super init];
    if (self) {
        self.levelMode = levelMode;
        [self createCardsArrays];
    }
    return self;
}

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [NSMutableArray new];
    }
    return _cards;
}

#pragma mark- CollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  self.rowsCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.columnsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCellIdentifier" forIndexPath:indexPath];
    Card *card = [self cardAtIndexPath:indexPath];
    cell.frontImageView.image = card.cardImage;
    return cell;
}

#pragma mark - Help methods

- (NSInteger)uniqueCardsCount {
    // in cards array all cards are doubled
    return self.cards.count/2;
}

- (Card *)cardAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row + (indexPath.section * self.columnsCount);
    if (index < 0 || index > self.cards.count) {
        return nil;
    }
    Card *card = self.cards[index];
    NSLog(@"Card index: %ld", (long)index);
    return card;
}

- (void)createCardsArrays {
    // form the images array
    NSMutableArray *finalNames = nil;
    NSInteger cardCount = 0;
    switch (self.levelMode) {
        case LevelModeEasy:
        {
            finalNames = [@[@"appleW", @"blueberriesW", @"carrotW", @"lettuceW", @"mushroomW", @"potatoW", @"radishW", @"strawberryW", @"sugar_snapW", @"tomatoW"] mutableCopy];
            cardCount = easyLevelCardCount;
            self.columnsCount = 4;
            self.rowsCount = 2;
        }
            break;
        case LevelModeNormal:
        {
            finalNames = [@[@"1_fishW", @"antW", @"bear_mac_archigraphsW", @"dragon_flyW", @"elephantW", @"hp_boyW", @"hp_catW", @"hp_dogW", @"hp_girlW", @"ladybugW", @"penguinW", @"silly_boy_archigraphsW", @"turtleW"] mutableCopy];
            cardCount = normalLevelCardCount;
            self.columnsCount = 4;
            self.rowsCount = 3;
        }
            break;
        case LevelModeHard:
        {
            finalNames = [@[@"aeroplaneW", @"bugattiW", @"busW", @"carW", @"suitcaseW", @"trainW", @"travel_busW", @"1_fishW", @"antW", @"bear_mac_archigraphsW", @"dragon_flyW", @"elephantW", @"hp_boyW", @"hp_catW", @"hp_dogW", @"hp_girlW", @"ladybugW", @"penguinW", @"silly_boy_archigraphsW", @"turtleW"] mutableCopy];
            cardCount = hardLevelCardCount;
            self.columnsCount = 6;
            self.rowsCount = 3;
        }
            break;
            
        default:
            break;
    }
    
    [finalNames shuffle];
    
    NSMutableArray *cardPicturesNames = [NSMutableArray new];
    
    // Double the pictures
    for (int i = 0; i < cardCount/2; i++) {
        [cardPicturesNames addObject:finalNames[i]];
        [cardPicturesNames addObject:finalNames[i]];
    }
    
    [cardPicturesNames shuffle];
    
    for (NSString *cardName in cardPicturesNames) {
        Card *card = [[Card alloc] initWithName:cardName];
        [self.cards addObject:card];
    }
    
    
}
@end
