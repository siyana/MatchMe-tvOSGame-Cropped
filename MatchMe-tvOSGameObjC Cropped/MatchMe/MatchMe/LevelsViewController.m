//
//  LevelsViewController.m
//  MatchMe
//
//  Created by Siyana Slavova on 2/22/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import "LevelsViewController.h"

#import "LevelTableViewCell.h"
#import "GameViewController.h"

@interface LevelsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) LevelMode choosenLevelMode;
@property (assign, nonatomic) BOOL shouldHandleDeepLink;

@end

@implementation LevelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.shouldHandleDeepLink) {
        [self openLevelMode:self.choosenLevelMode];
    }
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return LevelsCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LevelCellIdentifier" forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case LevelModeEasy:
            [cell configureWithLevelNumber:1 + LevelModeEasy title:@"Fruits & Vegetables" description:@"This is easy level, you have to find 4 couples cards among 8 cards of different kinds of fruits and vegetables." imageNames:@[@"apple", @"potato", @"strawberry"]];
            break;
        case LevelModeNormal:
            [cell configureWithLevelNumber: 1 +LevelModeNormal title:@"Living Creatures" description:@"This is normal level, you have to find 6 couples cards among 12 cards of different kinds of living creatures." imageNames:@[@"penguin", @"hp_dog", @"bear_mac_archigraphs"]];
            break;
        case LevelModeHard:
            [cell configureWithLevelNumber: 1 + LevelModeHard title:@"Mixed" description:@"In the hard levels, you have to find 9 couples cards among 18 cards, the level combine previous two and add some traveling options." imageNames:@[@"bugatti", @"hp_girl", @"travel_bus"]];
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    //TODO: Task: Improve focus
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self openLevelMode:indexPath.section];
}

#pragma mark - Help methods

- (void)shouldOpenLevelFromDeepLinkWithlevelMode:(LevelMode)choosenLevelMode
{
    if (choosenLevelMode < LevelsCount) {
        self.shouldHandleDeepLink = YES;
        self.choosenLevelMode = choosenLevelMode;
    } else {
        self.shouldHandleDeepLink = NO;
    }
}

- (void)openLevelMode:(LevelMode)levelMode {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    GameViewController *gameViewController = [storyboard instantiateViewControllerWithIdentifier:@"GameViewControllerStoryboardID"];
    gameViewController.selectedLevelMode = levelMode;
    [self.navigationController pushViewController:gameViewController animated:YES];
}

@end
