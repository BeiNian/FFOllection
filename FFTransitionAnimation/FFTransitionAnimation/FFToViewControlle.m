//
//  FFToViewControlle.m
//  FFTransitionAnimation
//
//  Created by cts on 2018/5/23.
//  Copyright © 2018年 cts. All rights reserved.
//

#import "FFToViewControlle.h"
#import "HTTPManager.h"
#import "FFTransitionConst.h"

@interface FFToViewControlle ()
@property (nonatomic, nullable, weak) NSTimer *timer;

@end

@implementation FFToViewControlle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [UIView animateWithDuration:0.5 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}

@end
