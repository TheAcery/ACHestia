//
//  ACHFirstViewController.m
//  ACHestia
//
//  Created by Acery on 2018/10/19.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHFirstViewController.h"

@interface ACHFirstViewController ()

@end

@implementation ACHFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, 0, 30, 30);
//    button.backgroundColor = UIColor.redColor;
//
    self.navigationItem.title = @"11222";
//
//    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
