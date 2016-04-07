//
//  LevelTableViewCell.h
//  MatchMe
//
//  Created by Siyana Slavova on 2/22/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelTableViewCell : UITableViewCell

- (void)configureWithLevelNumber:(NSInteger)levelNumber title:(NSString *)levelTitle description:(NSString *)levelDescription imageNames:(NSArray *)imageNames;
- (void)becomeOnFocus:(BOOL)onFocus;
@end
