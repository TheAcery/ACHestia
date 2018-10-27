//
//  ACHNAVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//  项目中所有NAVC的父类

#import "ACHNAVC.h"

#import "ACHButton.h"

@interface ACHNAVC () <UIGestureRecognizerDelegate>

@end

@implementation ACHNAVC



#pragma mark - view load funs
/****************************************************************************************************************/

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //在viewDidAppear中修改背景图片
    
    //    [self.navigationBar setShadowImage:[UIImage alloc]];
    
    [self setBarBKColor:UIColor.whiteColor];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    
}


#pragma mark - funs
/****************************************************************************************************************/

/**
 * 设置tabBar的属性
 */

-(void)setUpNAVCWithTitle:(NSString *)title ImageName:(NSString *)imageName SelectedImage:(NSString *)selectedImage
{
    self.tabBarItem.title = title;
    
    NSDictionary *normalAttributedDict = @{NSForegroundColorAttributeName:UIColor.blackColor};
    NSDictionary *selectedAttributedDict = @{NSForegroundColorAttributeName:UIColor.redColor};
    
    [self.tabBarItem setTitleTextAttributes:normalAttributedDict forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:selectedAttributedDict forState:UIControlStateSelected];
    
    [self.tabBarItem setImage:[UIImage UNRenderimageNamed:imageName]];
    [self.tabBarItem setSelectedImage:[UIImage UNRenderimageNamed:selectedImage]];
    
}


/**
 * 使用子控件的方式设置bar背景的颜色，这样不会对bar的位置产生影响
 */


-(void)setBarBKColor:(UIColor *)color
{
    for (UIView *view in self.navigationBar.subviews)
    {
        if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")])
        {
            UIImageView *bkkView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, view.ACheight)];
            bkkView.image = [UIImage imageWithUIColor:color];
            [view addSubview:bkkView];
            
            for (UIView *otherView in view.subviews)
            {
                if ([otherView isKindOfClass:NSClassFromString(@"UIVisualEffectView")])
                {
                    otherView.hidden = YES;
                    
                }
            }
        }
    }
    
}


/**
 * 重写父类的 pushViewController: animated: 同时在非根控制器跳转的时候设置hidesBottomBarWhenPushed和统一的返回按钮
 */

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count >= 1)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [self addBackButton];
    }
    [super pushViewController:viewController animated:animated];
    
}

/**
 * 为非根控制器添加统一的返回按钮
 */

-(UIBarButtonItem *)addBackButton
{
    ACHButton *backButton = [ACHButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(backButtonClip:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"hybrid_goBack"] forState:UIControlStateNormal];
    [backButton sizeToFit];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    return backItem;
}

#pragma mark - action
/****************************************************************************************************************/
/**
 * 为非根控制器导航栏的统一返回按钮添加监听者
 */

-(void)backButtonClip:(ACHButton *)btn
{
    [self popViewControllerAnimated:YES];
}


#pragma mark - UIGestureRecognizerDelegate
/****************************************************************************************************************/

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count > 1)
    {
        return YES;
    }
    
    return NO;
}

@end
