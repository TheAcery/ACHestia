//
//  ACHFirstViewController.m
//  ACHestia
//
//  Created by Acery on 2018/10/19.
//  Copyright © 2018年 Acery. All rights reserved.
//

/**
 * 描述了FirstView模块的所有跳转控制器的父类，他们自身的NAVCbar是隐藏的，使用自定义的NAVCbar
 * 向外界暴露ACHFirstViewNAVCBar的一些属性，同时重写set方法来设置ACHFirstViewNAVCBar的这些属性
 * 或者直接暴露ACHFirstViewNAVCBar的属性
 */

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


#pragma mark - set funs
/****************************************************************************************************************/

- (void)setBarTitle:(NSString *)barTitle
{
    _barTitle = barTitle;
    
    self.bar.title = barTitle;
}

- (void)setLeftItem:(UIBarButtonItem *)leftItem
{
    _leftItem = leftItem;
    self.bar.leftItem = leftItem;
}

- (void)setLeftItems:(NSArray<UIBarButtonItem *> *)leftItems
{
    _leftItems = leftItems;
    
    self.bar.leftItems = leftItems;
}

- (void)setRightItem:(UIBarButtonItem *)rightItem
{
    _rightItem = rightItem;
    self.bar.rightItem = rightItem;
}

- (void)setRightItems:(NSArray<UIBarButtonItem *> *)rightItems
{
    _rightItems = rightItems;
    
    self.bar.rightItems = rightItems;
}


#pragma mark - funs
/****************************************************************************************************************/


-(void)setUpBar
{
    UIView *headerView =
    ({
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, HeaderBarHeight)];
        headerView.backgroundColor = UIColor.whiteColor;
        
        if (self.barTitle == nil)
        {
            self.barTitle = @"title";
        }
        
        ACHFirstViewNAVCBar *bar = [ACHFirstViewNAVCBar FirstViewNAVCBarWithTitle:self.barTitle];
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
