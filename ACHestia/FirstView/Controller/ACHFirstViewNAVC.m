//
//  ACHFirstViiewVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//  首页的NAVC

#import "ACHFirstViewNAVC.h"
#import "ACHFirstViewTableVC.h"

@interface ACHFirstViewNAVC ()

@end

@implementation ACHFirstViewNAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ACHFirstViewTableVC *firstViewTableVC = [[ACHFirstViewTableVC alloc]init];
    
    [self addChildViewController:firstViewTableVC];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationBar setHidden: YES];
    
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setUpNAVCWithTitle:@"首页" ImageName:@"icon_attention_unselect" SelectedImage:@"icon_attention_selected"];
    }
    return self;
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.childViewControllers.count != 0)
//    {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    [super pushViewController:viewController animated:animated];
//
//}



@end
