//
//  FFTransitionConst.h
//  FFTransitionAnimation
//
//  Created by cts on 2018/5/29.
//  Copyright © 2018年 cts. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kScreenSize           [[UIScreen mainScreen] bounds].size
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height

typedef NS_ENUM(NSUInteger, FFInteractiveTransitionType) {
    FFInteractiveTransitionPush = 0,//管理push动画
    FFInteractiveTransitionPop, //管理pop动画
    FFInteractiveTransitionPresent,
    FFInteractiveTransitionDismiss
};

typedef NS_ENUM(NSUInteger, FFInteractiveAnimationStyle) {
    FFInteractiveAnimationBackdrop = 1,    // 动画生成阴影背景
};

@interface FFTransitionConst : NSObject

@end
