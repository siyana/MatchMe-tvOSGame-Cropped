//
//  AlerManager.m
//  MatchMe
//
//  Created by Siyana Slavova on 2/26/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import "AlerManager.h"
#import "AppDelegate.h"

@implementation AlerManager

+ (void)showErrorAlertWithMessage:(NSString *)message withPresenter:(UIViewController *)presenter {
    
    [self showErrorAlertWithMessage:message withPresenter:presenter completionBlock:nil];
    
}

+ (void)showErrorAlertWithMessage:(NSString *)message withPresenter:(UIViewController *)presenter completionBlock:(kAlertIndexBlock)completion
{
    [self showAlertWithTitle:@"Error" message:message cancelButtonTitle:@"Ok" otherButtonTitles:nil completionBlock:completion withPresenter:presenter];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message withPresenter:(UIViewController *)presenter {
    
    [self showAlertWithTitle:title message:message cancelButtonTitle:@"Ok" otherButtonTitles:nil completionBlock:nil withPresenter:presenter];
    
}

+ (void)showAlertWithMessage:(NSString *)message withPresenter:(UIViewController *)presenter
{
    [self showAlertWithMessage:message withPresenter:presenter completionBlock:nil];
}

+ (void)showAlertWithMessage:(NSString *)message withPresenter:(UIViewController *)presenter completionBlock:(kAlertIndexBlock)completion
{
    [self showAlertWithMessage:message cancelButtonTitle:@"Ok" otherButtonTitles:nil withPresenter:presenter completionBlock:completion];
    
}

+ (void)showAlertWithMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles withPresenter:(UIViewController *)presenter completionBlock:(kAlertIndexBlock)completion
{
    [self showAlertWithTitle:@"" message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles completionBlock:completion withPresenter:presenter];
}

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherButtonTitles
           completionBlock:(kAlertIndexBlock)completion
             withPresenter:(UIViewController *)presenter {
    
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (completion) {
            completion(0, 0);
        }
    }];
    [controller addAction:cancelAction];
    
    [otherButtonTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (completion) {
                completion(idx + 1, 0);
            }
        }];
        [controller addAction:action];
    }];
    
    [self presentAlertController:controller withPresentingViewController:presenter];
    
}

+ (void)presentAlertController:(UIAlertController *)alertController withPresentingViewController:(UIViewController *)presentingController {
    if (!alertController) {
        return;
    }
    
    if (!presentingController) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        presentingController = appDelegate.window.rootViewController;
        
        while (presentingController.presentedViewController) {
            presentingController = presentingController.presentedViewController;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [presentingController presentViewController:alertController animated:YES completion:nil];
    });
}



@end
