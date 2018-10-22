//
//  ACHFirstViewController.m
//  ACHestia
//
//  Created by Acery on 2018/10/19.
//  Copyright © 2018年 Acery. All rights reserved.
//  描述了FirstView模块的所有跳转控制器的父类，他们自身的NAVCbar是隐藏的，使用自定义的NAVCbar


#import "ACHFirstViewController.h"

//other

//bar
#import "ACHFirstViewNAVCBar.h"


@interface ACHFirstViewController ()<UIGestureRecognizerDelegate>

/**自定义的导航栏*/
@property (nonatomic, weak) ACHFirstViewNAVCBar *bar;

@end

@implementation ACHFirstViewController




#pragma mark - view load
/****************************************************************************************************************/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //自定义导航栏
    [self setUpBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //启用侧滑手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    self.navigationController.navigationBar.alpha = 0.0;
}


#pragma mark - funs
/****************************************************************************************************************/


-(void)setUpBar
{
    UIView *headerView =
    ({
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, HeaderBarHeight)];
        headerView.backgroundColor = UIColor.whiteColor;
        
        ACHFirstViewNAVCBar *bar = [ACHFirstViewNAVCBar FirstViewNAVCBarWithTitle:@"title"];
        self.bar = bar;
        
        bar.frame = CGRectMake(0, StatusBarHeight, bar.ACwidth, bar.ACheight);
        
        [headerView addSubview:bar];
        headerView;
    });
    
    [self.view addSubview:headerView];
}

/**为自定义控制器添加item*/
-(void)addItems:(ACHFirstViewNAVCBar *)bar
{
    UIBarButtonItem *leftButton =
    ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:button];
        leftButton;
    });

    UIBarButtonItem *rightButton =
    ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.blueColor;

        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:button];
        rightButton;
    });

    bar.leftItem = leftButton;

    bar.rightItem = rightButton;
}


#pragma mark - UIGestureRecognizerDelegate
/****************************************************************************************************************/

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

#pragma mark - action
/****************************************************************************************************************/


-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
