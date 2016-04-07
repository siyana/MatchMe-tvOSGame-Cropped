//
//  AlerManager.h
//  MatchMe
//
//  Created by Siyana Slavova on 2/26/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^kAlertIndexBlock)(NSUInteger buttonIndex, NSInteger cancelButtonIndex);
typedef void (^kAlertCancelButtonTappedBlock)();

@interface AlerManager : NSObject

+ (void)showErrorAlertWithMessage:(NSString *)message withPresenter:(UIViewController *)presenter;
+ (void)showErrorAlertWithMessage:(NSString *)message withPresenter:(UIViewController *)presenter completionBlock:(kAlertIndexBlock)completion;

+ (void)showAlertWithMessage:(NSString *)message withPresenter:(UIViewController *)presenter;
+ (void)showAlertWithMessage:(NSString *)message withPresenter:(UIViewController *)presenter completionBlock:(kAlertIndexBlock)completion;

+ (void)showAlertWithMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles withPresenter:(UIViewController *)presenter completionBlock:(kAlertIndexBlock)completion;

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherButtonTitles
           completionBlock:(kAlertIndexBlock)completion
             withPresenter:(UIViewController *)presenter;

@end
