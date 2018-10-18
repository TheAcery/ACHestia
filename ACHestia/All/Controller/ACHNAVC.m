//
//  ACHNAVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//  项目中所有NAVC的父类

#import "ACHNAVC.h"

@interface ACHNAVC ()

@end

@implementation ACHNAVC

-(void)setUpNAVCWithTitle:(NSString *)title ImageName:(NSString *)imageName SelectedImage:(NSString *)selectedImage
{
    
    [self.navigationBar setBackgroundImage:[UIImage imageWithUIColor:UIColor.whiteColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage alloc]];
    
    self.tabBarItem.title = title;
    
    NSDictionary *normalAttributedDict = @{NSForegroundColorAttributeName:UIColor.blackColor};
    NSDictionary *selectedAttributedDict = @{NSForegroundColorAttributeName:UIColor.redColor};
    
    [self.tabBarItem setTitleTextAttributes:normalAttributedDict forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:selectedAttributedDict forState:UIControlStateSelected];
    
    [self.tabBarItem setImage:[UIImage UNRenderimageNamed:imageName]];
    [self.tabBarItem setSelectedImage:[UIImage UNRenderimageNamed:selectedImage]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count != 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
    
}


@end
