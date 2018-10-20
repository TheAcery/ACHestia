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
    self.tabBarItem.title = title;
    
    NSDictionary *normalAttributedDict = @{NSForegroundColorAttributeName:UIColor.blackColor};
    NSDictionary *selectedAttributedDict = @{NSForegroundColorAttributeName:UIColor.redColor};
    
    [self.tabBarItem setTitleTextAttributes:normalAttributedDict forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:selectedAttributedDict forState:UIControlStateSelected];
    
    [self.tabBarItem setImage:[UIImage UNRenderimageNamed:imageName]];
    [self.tabBarItem setSelectedImage:[UIImage UNRenderimageNamed:selectedImage]];
}


#pragma mark - funs
/****************************************************************************************************************/

//使用子控件的方式设置bar背景的颜色，这样不会对bar的位置产生影响
-(void)setBarBKColor:(UIColor *)color
{
    for (UIView *view in self.navigationBar.subviews)
    {
        if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")])
        {
            UIImageView *bkkView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 64)];
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationBar setShadowImage:[UIImage alloc]];
    
    [self setBarBKColor:UIColor.whiteColor];
}

@end
