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
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.downToUpDataView startAnimate];
}



@end
