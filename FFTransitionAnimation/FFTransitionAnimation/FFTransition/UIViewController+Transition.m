//
//  UIViewController+Transition.m
//  FFTransitionAnimation
//
//  Created by cts on 2018/5/29.
//  Copyright © 2018年 cts. All rights reserved.
//

#import "UIViewController+Transition.h"
#import "FFInteractiveTransition.h"

@implementation UIViewController (Transition)
#pragma mark - push / pop
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    
    return  [FFInteractiveTransition transitionWithType:operation == UINavigationControllerOperationPush ? FFInteractiveTransitionPush : FFInteractiveTransitionPop AnimmationStyle:FFInteractiveAnimationBackdrop];
}

#pragma mark - presented / dismissed
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [FFInteractiveTransition transitionWithType:FFInteractiveTransitionPresent AnimmationStyle:FFInteractiveAnimationBackdrop];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [FFInteractiveTransition transitionWithType:FFInteractiveTransitionDismiss AnimmationStyle:FFInteractiveAnimationBackdrop];
}
@end
