//
//  HTTPManager.m
//  FFTransitionAnimation
//
//  Created by cts on 2018/5/28.
//  Copyright © 2018年 cts. All rights reserved.
//

#import "HTTPManager.h"

@interface HTTPManager ()
@property (nonatomic, nullable, strong) NSMutableDictionary *present;

@end

@implementation HTTPManager
+ (instancetype _Nonnull)sharedInstance
{
    static HTTPManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [HTTPManager new];
        instance.present = [NSMutableDictionary dictionary];
        
    });
    
    return instance;
}

- (void)convertGETParametersWith:(NSDictionary *)parameters {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        int num = arc4random() % 10;
        [NSThread sleepForTimeInterval:num];
        NSLog(@"-->%d,-->%@,-->%@",num,parameters,[NSThread currentThread]);
        [_present removeObjectForKey:[parameters description]];
        if (_present.allKeys.count == 0) {
            NSLog(@"所有请求完成了");
        }
        
    });
    NSLog(@"parameters 创建View%@",parameters);
    [_present setValue:[parameters description] forKey:[parameters description]];
}



@end
