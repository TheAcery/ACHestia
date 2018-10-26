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

@end

@implementation ACHMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    testLabel.text = @"test";
    testLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:testLabel];
    testLabel.center = self.view.center;
    
    ACHDownToUpDataView *view = [[ACHDownToUpDataView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    [self.view addSubview:view];
    view.center = self.view.center;
}



@end
