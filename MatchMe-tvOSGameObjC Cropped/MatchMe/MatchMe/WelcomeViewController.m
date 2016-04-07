//
//  WelcomeViewController.m
//  MatchMe
//
//  Created by Siyana Slavova on 2/22/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LevelsViewController.h"

#import "NSUserDefaultsManager.h"
#import "AlerManager.h"
#import "NSString+Time.h"

@interface WelcomeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIButton *bestScoreButton;

@property (assign, nonatomic) LevelMode choosenLevelMode;
@property (assign, nonatomic) BOOL shouldHandleDeepLink;

@property (strong, nonatomic) UIFocusGuide *focusGuide;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //TODO: Task: Create focus guide
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [NSUserDefaultsManager saveUserName:self.nameTextField.text];
}

#pragma mark - Focus

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
   //TODO: Task: Implement focus guide changes
}

- (UIView *)preferredFocusedView {
    return self.nameTextField;
}

#pragma mark - Actions
- (IBAction)checkBestScoreButtonPressed:(UIButton *)sender {
    [self showBestScoreAlert];
}

- (void)handleDeepLinkForLevel:(NSString *)level {
    NSInteger levelMode = [level intValue] - 1;
    self.shouldHandleDeepLink = YES;
    self.choosenLevelMode = levelMode;
    [self performSegueWithIdentifier:@"LevelsSegue" sender:self];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LevelsSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[LevelsViewController class]]) {
            if (self.shouldHandleDeepLink) {
                LevelsViewController *destinationController = (LevelsViewController *)segue.destinationViewController;
                [destinationController shouldOpenLevelFromDeepLinkWithlevelMode:self.choosenLevelMode];
            }
        }
    }
}

#pragma mark - Help methods

- (void)showBestScoreAlert {
    
    [AlerManager showAlertWithMessage:[self bestScoreMessage] withPresenter:self];
}

- (NSString *)bestScoreMessage {
    
    NSString *bestScoreMessage = @"";
    for (int i = LevelModeEasy; i <= LevelModeHard; i++) {
        NSDictionary *bestScoreDict = [NSUserDefaultsManager currentBestScoreDictionaryForLevelMode:i];
        NSString *message = @"";
        if (!bestScoreDict) {
            message = [NSString stringWithFormat:@"No one has finished %@ yet", [Configurations nameForLevelMode:i]];
        } else {
            NSString *userName = [bestScoreDict objectForKey:kBestPlayerNameKey];
            NSNumber *bestTimeScore = [bestScoreDict objectForKey:kBestPlayerTimeKey];
            message = [NSString stringWithFormat:@"Best score for the %@ belongs to %@. It is %@.", [Configurations nameForLevelMode:i], userName, [NSString stringFromTimeInterval:[bestTimeScore doubleValue]]];
        }
        
        bestScoreMessage = [bestScoreMessage stringByAppendingString:@"\n"];
        bestScoreMessage = [bestScoreMessage stringByAppendingString:message];
    }
    
    return bestScoreMessage;
    
}

@end
