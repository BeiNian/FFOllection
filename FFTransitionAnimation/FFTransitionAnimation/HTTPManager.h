//
//  HTTPManager.h
//  FFTransitionAnimation
//
//  Created by cts on 2018/5/28.
//  Copyright © 2018年 cts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPManager : NSObject
+ (instancetype)sharedInstance;

- (void)convertGETParametersWith:(NSDictionary *)paramete_Nullablers;

@end
