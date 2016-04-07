//
//  CardCollectionViewCell.h
//  MatchMe
//
//  Created by Siyana Slavova on 2/23/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@property (nonatomic) BOOL isActive;
@property (nonatomic, readonly) BOOL isShowingBack;

- (void)flip;

@end
