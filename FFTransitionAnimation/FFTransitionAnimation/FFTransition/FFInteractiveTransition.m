//
//  FFInteractiveTransition.m
//  FFTransitionAnimation
//
//  Created by cts on 2018/5/29.
//  Copyright © 2018年 cts. All rights reserved.
//  UINavigationControllerDelegate push 遵守代理 ,
//  UIViewControllerTransitioningDelegate Presenter 遵守代理


#import "FFInteractiveTransition.h"

@interface FFInteractiveTransition () 
@property (nonatomic, assign) FFInteractiveTransitionType type;
@property (nonatomic, assign) FFInteractiveAnimationStyle style;
@end

@implementation FFInteractiveTransition


+ (instancetype)transitionWithType:(FFInteractiveTransitionType)type AnimmationStyle:(FFInteractiveAnimationStyle)style {
    return [[self alloc] initWithTransitionType:type AnimmationStyle:style];
}

- (instancetype)initWithTransitionType:(FFInteractiveTransitionType)type AnimmationStyle:(FFInteractiveAnimationStyle)style {
    self = [super init];
    if (self) {
        _type = type;
        _style = style;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
   
    if (_type == FFInteractiveTransitionPush || _type == FFInteractiveTransitionPresent ) {
        
        switch (_style) {
            case FFInteractiveAnimationBackdrop:
                [self translucentBackdropSenterAnimation:transitionContext];
                break;
                
            default:
                break;
        }
        
    }
    else {
        switch (_style) {
            case FFInteractiveAnimationBackdrop:
                [self translucentBackdropExitAnimation:transitionContext];
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - FFInteractiveAnimationBackdrop Animation
- (void)translucentBackdropSenterAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    // 对View截图用于视图过渡，并将视图转换到当前控制器的坐标 传入YES  是一张 透明度 为 0  的快照。
    UIView *tempView = [fromView snapshotViewAfterScreenUpdates:NO];
    fromView.hidden = YES;
    [containerView addSubview:tempView];
    [containerView addSubview:toView];
    
    toView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    // Animation
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            toView.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }]; 
}

- (void)translucentBackdropExitAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    // 对View截图用于视图过渡，并将视图转换到当前控制器的坐标 传入YES  是一张 透明度 为 0  的快照。
    UIView *tempView = [fromView snapshotViewAfterScreenUpdates:NO];
    
    [containerView addSubview:tempView];
    [containerView addSubview:toView];
    
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:.5 animations:^{
            fromView.transform = CGAffineTransformIdentity;
        }];
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if (![transitionContext transitionWasCancelled]) {
            toView.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
    
}

@end
