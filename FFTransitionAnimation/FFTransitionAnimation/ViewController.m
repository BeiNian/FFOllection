//
//  ViewController.m
//  FFTransitionAnimation
//
//  Created by cts on 2018/5/23.
//  Copyright © 2018年 cts. All rights reserved.
//

#import "ViewController.h"
#import "FFToViewControlle.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
    FFToViewControlle *toVC = [FFToViewControlle new];
    self.navigationController.delegate = toVC;
    [self.navigationController pushViewController:toVC animated:YES];
    
//    toVC.transitioningDelegate = toVC;
//    [self presentViewController:toVC animated:YES completion:nil];
    
}

@end
