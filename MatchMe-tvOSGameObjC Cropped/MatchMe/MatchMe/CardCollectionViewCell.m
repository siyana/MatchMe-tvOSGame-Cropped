//
//  CardCollectionViewCell.m
//  MatchMe
//
//  Created by Siyana Slavova on 2/23/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import "CardCollectionViewCell.h"

@interface CardCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;

@property (nonatomic, readwrite) BOOL isShowingBack;

@end

@implementation CardCollectionViewCell

- (void)awakeFromNib {
    self.isShowingBack = YES;
    self.isActive = YES;
    self.cardImageView.image = [UIImage imageNamed:@"cards-back-white-with-border"];
    self.frontImageView.alpha = 0;
}

- (void)prepareForReuse {
    self.frontImageView.image = nil;
}

- (void)flip {
    [UIView animateWithDuration:0.15 animations:^{
        self.cardImageView.alpha = self.isShowingBack ? 0 : 1;
        self.frontImageView.alpha = self.isShowingBack ? 1 : 0;
    } completion:^(BOOL finished) {
        self.isShowingBack = !self.isShowingBack;
    }];
}

@end
