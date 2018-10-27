//
//  ACHMeVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/25.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHMeVC.h"

#import "ACHDownToUpDataView.h"

@interface ACHMeVC ()

@property (nonatomic, weak) ACHDownToUpDataView *downToUpDataView;

@end

@implementation ACHMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    UIView *view = [[UIView alloc]initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3];
//    view.
    [self.view addSubview:view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.downToUpDataView startAnimate];
}



@end
