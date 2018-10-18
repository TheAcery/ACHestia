//
//  ACHTabBarController.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//  管理其他的子控制器 -- NAVC

#import "ACHTabBarController.h"

///////////////////////////////////// ---- NAVC
#import "ACHFirstViewNAVC.h"
#import "ACHDelicacyNAVC.h"
#import "ACHShopCarNAVC.h"
#import "ACHMeNAVC.h"



@interface ACHTabBarController ()

@end

@implementation ACHTabBarController

#pragma mark - init funs
/****************************************************************************************************************/

+(instancetype)tabBarController
{
    return [[ACHTabBarController alloc]init];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        //跳转到其他NAVC
        [self setUpAllChildViewController];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tabBar setBackgroundImage:[UIImage imageWithUIColor:UIColor.whiteColor]];
}

#pragma mark - funs
/****************************************************************************************************************/

//在这里初始化所有的NAVC
-(void)setUpAllChildViewController
{
    //FirstView
    ACHFirstViewNAVC *firstVC = [[ACHFirstViewNAVC alloc]init];
    [self addChildViewController:firstVC];
    
    ACHDelicacyNAVC *delicacyVC = [[ACHDelicacyNAVC alloc]init];
    [self addChildViewController:delicacyVC];
    
    ACHShopCarNAVC *shopCarVC = [[ACHShopCarNAVC alloc]init];
    [self addChildViewController:shopCarVC];
    
    ACHMeNAVC *meVC = [[ACHMeNAVC alloc]init];
    [self addChildViewController:meVC];
}

@end
