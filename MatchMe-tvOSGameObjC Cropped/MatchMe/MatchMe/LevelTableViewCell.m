//
//  LevelTableViewCell.m
//  MatchMe
//
//  Created by Siyana Slavova on 2/22/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import "LevelTableViewCell.h"

@interface LevelTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *levelNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelImage1;
@property (weak, nonatomic) IBOutlet UIImageView *levelImage2;
@property (weak, nonatomic) IBOutlet UIImageView *levelImage3;

@end

@implementation LevelTableViewCell

- (void)awakeFromNib {
    self.contentView.layer.borderWidth = 4;
    self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)configureWithLevelNumber:(NSInteger)levelNumber title:(NSString *)levelTitle description:(NSString *)levelDescription imageNames:(NSArray *)imageNames {
    self.levelNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)levelNumber];
    self.levelTitleLabel.text = levelTitle;
    self.levelDescriptionLabel.text = levelDescription;
    [self.levelImage1 setImage:[UIImage imageNamed:imageNames[0]]];    
    [self.levelImage2 setImage:[UIImage imageNamed:imageNames[1]]];
    [self.levelImage3 setImage:[UIImage imageNamed:imageNames[2]]];
    
    self.levelImage1.hidden = YES;
    self.levelImage2.hidden = YES;
    self.levelImage3.hidden = YES;
}

#pragma mark - Focus

- (BOOL)canBecomeFocused {
    return YES;
}

- (void)becomeOnFocus:(BOOL)onFocus {
    self.contentView.layer.opacity = onFocus ? 1 : 0.7;
    self.levelImage1.hidden = !onFocus;
    self.levelImage2.hidden = !onFocus;
    self.levelImage3.hidden = !onFocus;
}

@end
