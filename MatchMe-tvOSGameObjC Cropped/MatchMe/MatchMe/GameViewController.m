//
//  GameViewController.m
//  MatchMe
//
//  Created by Siyana Slavova on 2/23/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import "GameViewController.h"

#import "NSString+Time.h"

#import "CardDataSource.h"
#import "CardCollectionViewCell.h"

#import "NSUserDefaultsManager.h"
#import "AlerManager.h"

CGFloat const minCellSpacing = 20.f;

@interface GameViewController () <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *triesCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;

@property (strong, nonatomic) CardDataSource *cardDataSource;
@property (strong, nonatomic) NSIndexPath *openCardIndexPath;
@property (nonatomic) NSInteger triesCount;
@property (nonatomic) NSInteger matchesCount;

@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) NSTimeInterval startTimeInterval;
@property (nonatomic) NSTimeInterval pausedTimeInterval;
@property (nonatomic) NSTimeInterval resumedTimeInterval;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //TODO: Task: Create and implement gestures
    
    [self configureTitle];
    
    self.cardDataSource = [[CardDataSource alloc] initWithLevelMode:self.selectedLevelMode];
    self.collectionView.dataSource = self.cardDataSource;
    
    self.triesCount = 0;
    self.matchesCount = 0;
    
    self.startTimeInterval = [NSDate timeIntervalSinceReferenceDate];
    [self resumeTimer];
}

#pragma mark - Focus

- (UIView *)preferredFocusedView {
    return self.collectionView;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canFocusItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


#pragma mark - Actions
- (IBAction)exitButtonTapped:(UIButton *)sender {
    [self showExitAlert];
}

- (IBAction)bestScoreButtonTapped:(UIButton *)sender {
    [self showBestScoreAlert];
}

#pragma mark - CollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CardCollectionViewCell *currentCell = (CardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (currentCell.isShowingBack) {
        //open current card
        [currentCell flip];
        
        if (self.openCardIndexPath == nil) {
            [self increaseTriesCount];
            self.openCardIndexPath = indexPath;
        } else {
            // check if cards match
            Card *openedCard = [self.cardDataSource cardAtIndexPath:self.openCardIndexPath];
            Card *currentCard = [self.cardDataSource cardAtIndexPath:indexPath];
            
            CardCollectionViewCell *oldCell = (CardCollectionViewCell *)[collectionView cellForItemAtIndexPath:self.openCardIndexPath];
            
            if ([openedCard isEqual:currentCard]) {
                self.matchesCount++;
                // make cells inactive because they have already been hit
                oldCell.isActive = NO;
                currentCell.isActive = NO;
                
                if (self.matchesCount == [self.cardDataSource uniqueCardsCount]) {
                    [self saveUserResult];
                }
            } else {
                self.collectionView.userInteractionEnabled = NO;
                dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW,  0.3 * NSEC_PER_SEC);
                dispatch_after(time, dispatch_get_main_queue(), ^{
                    // flip back the two cells
                    [oldCell flip];
                    [currentCell flip];
                    
                    self.collectionView.userInteractionEnabled = YES;
                });
                
            }
            
            self.openCardIndexPath = nil;
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self cellSize];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat allCellsInColumnWidth = [self cellSize].width * (1.0f * self.cardDataSource.columnsCount);
    CGFloat minInterItemSpacing = (self.collectionView.frame.size.width - allCellsInColumnWidth) / (self.cardDataSource.columnsCount);
    return minInterItemSpacing;
}

#pragma mark - Timer methods

- (void)pauseTimer {
    self.pausedTimeInterval = [self elapsedTime] + self.pausedTimeInterval;
    [self.timer invalidate];
}

- (void)resumeTimer {
    self.resumedTimeInterval = [self elapsedTime] + self.resumedTimeInterval;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updatePlayTime:) userInfo:nil repeats:YES];
}

- (void)updatePlayTime:(NSTimer *)sender {
    self.timerLabel.text = [NSString stringFromTimeInterval:([self elapsedTime] - [self pausedTime])];
}

- (NSTimeInterval)elapsedTime {
    //Find the difference between current time and start time.
    NSInteger elapsedTime = [NSDate timeIntervalSinceReferenceDate] - self.startTimeInterval;
    return elapsedTime;
}

- (NSTimeInterval)pausedTime {
    NSInteger pausedTime = self.resumedTimeInterval - self.pausedTimeInterval;
    return pausedTime;
}

#pragma mark - Help Methods

- (void)increaseTriesCount {
    self.triesCount++;
    self.triesCountLabel.text = [NSString stringWithFormat:@"Tries: %ld", (long)self.triesCount];
}

- (CGFloat)cellMinHeight {
    CGFloat result = (self.collectionView.frame.size.height - (maxRowsCount * 2 * minCellSpacing))/maxRowsCount;
    return result;
}

- (CGSize)cellSize {
    return CGSizeMake([self cellMinHeight] * 0.7, [self cellMinHeight]);
}

- (void)saveUserResult {
    [self.timer invalidate];
    [NSUserDefaultsManager saveUserScoreIfNeeded:[self elapsedTime] levelMode:self.selectedLevelMode];
    NSString *message = [NSString stringWithFormat:@"Congrats %@, you've just finished %@.", [NSUserDefaultsManager currentUserName], self.titleLabel.text];
    
    [AlerManager showAlertWithMessage:message withPresenter:self];
}

- (void)configureTitle {
    switch (self.selectedLevelMode) {
        case LevelModeEasy:
            self.titleLabel.text = @"Level 1";
            break;
        case LevelModeNormal:
            self.titleLabel.text = @"Level 2";
            break;
        case LevelModeHard:
            self.titleLabel.text = @"Level 3";
            break;
        default:
            break;
    }
}

- (void)showBestScoreAlert {
    NSDictionary *bestScoreDict = [NSUserDefaultsManager currentBestScoreDictionaryForLevelMode:self.selectedLevelMode];
    
    NSString *message = @"";
    if (!bestScoreDict) {
        message = @"You are the first player for this level";
    } else {
        NSString *userName = [bestScoreDict objectForKey:kBestPlayerNameKey];
        NSNumber *bestTimeScore = [bestScoreDict objectForKey:kBestPlayerTimeKey];
        message = [NSString stringWithFormat:@"Best score for the level belongs to %@. It is %@.", userName, [NSString stringFromTimeInterval:[bestTimeScore doubleValue]]];
    }
    
    [self pauseTimer];
    __weak typeof(self) weakSelf = self;
    [AlerManager showAlertWithMessage:message withPresenter:self completionBlock:^(NSUInteger buttonIndex, NSInteger cancelButtonIndex) {
        [weakSelf resumeTimer];
    }];
}

- (void)showExitAlert {
    [self pauseTimer];
    __weak typeof(self) weakSelf = self;
    [AlerManager showAlertWithMessage:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Main screen", @"Levels screen"] withPresenter:self completionBlock:^(NSUInteger buttonIndex, NSInteger cancelButtonIndex) {
        if (buttonIndex == 1) {
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        } else if (buttonIndex == 2) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else if (buttonIndex == 0) {
            //Cancel button index is always 0
            [weakSelf resumeTimer];
        }
    }];
}

@end
