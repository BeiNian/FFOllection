//
//  FFInteractiveTransition.h
//  FFTransitionAnimation
//
//  Created by cts on 2018/5/29.
//  Copyright © 2018年 cts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FFTransitionConst.h"

@interface FFInteractiveTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithType:(FFInteractiveTransitionType)type AnimmationStyle:(FFInteractiveAnimationStyle)style;
@end
