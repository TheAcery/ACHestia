//
//  ACHFirstViewTableVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//  描述首页的tableview --- > 根控制器

#import "ACHFirstViewTableVC.h"
#import "ACHFirstViewTranslationAnimtor.h"

//view
#import "ACHFastView.h"
#import "ACHFirstViewTableHeadView.h"
#import "ACHFirstHeadView.h"
#import "ACHFirstViewTableViewCell.h"

//controller
#import "ACHFirstViewController.h"

/**新手界面*/
#import "ACHFastNewHandVC.h"

/**砍价界面*/
#import "ACHCutDownVC.h"

/**品牌界面*/
#import "ACHBrandVC.h"

#pragma mark - define
/****************************************************************************************************************/

#define FASTVIEWHIGHT 300.0
#define RowHeight 100

@interface ACHFirstViewTableVC () <UITableViewDelegate,UITableViewDataSource,ACHFastViewDelegate>

@property (nonatomic, strong) ACHFirstViewTranslationAnimtor *Animtor;

@property (nonatomic, weak) UITableView *tableView;

/**一直在屏幕顶部的view*/
@property (nonatomic, weak) UIView *headView;

/**在tableview前面的view*/
@property (nonatomic, weak) ACHFastView *fastView;

@end

@implementation ACHFirstViewTableVC


    NSString  *Identifier  = @"cell";



#pragma mark - lazy init
/****************************************************************************************************************/

- (ACHFirstViewTranslationAnimtor *)Animtor
{
    if (_Animtor == nil)
    {
        _Animtor = [[ACHFirstViewTranslationAnimtor alloc]init];
    }
    return _Animtor;
}

#pragma mark - viewload funs
/****************************************************************************************************************/

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpSubViews];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //这个VC的NAVCbar是始终隐藏的
    self.navigationController.navigationBar.alpha = 0.0;

}

#pragma mark - Table view data source
/****************************************************************************************************************/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACHFirstViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (cell == nil)
    {
        cell = [ACHFirstViewTableViewCell firstViewTableViewCell];
    }
    
    return cell;
}


-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

{
    ACHFirstViewTableHeadView *view = [ACHFirstViewTableHeadView firstViewTableHeadView];
    view.frame = CGRectMake(0, 0, view.ACwidth, HeaderBarHeight + 40);
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return HeaderBarHeight + 40;
}

#pragma mark -UITableViewDelegate
/****************************************************************************************************************/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACHFirstViewController *vc = [[ACHFirstViewController alloc]init];
    vc.view.backgroundColor = UIColor.yellowColor;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - UIScrollViewDelegate
/****************************************************************************************************************/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //随着tableView的滚动设置headerView的alpah
    CGFloat alpha = 1.0 * (scrollView.contentOffset.y/ 75);
    

    self.headView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:alpha];
    //设置 sectionHeadView 的阴影
}

#pragma mark - setUp
/****************************************************************************************************************/


-(void)setUpSubViews
{
    //init fastView
    UIView *fastView =
    ({
        ACHFastView *fastView = [ACHFastView fastView];
        fastView.delegate = self;
        self.fastView = fastView;
        fastView;
    });
    
    //init tableView
    UITableView *tableView =
    ({
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, SCRENNBOUNDS.size.height - TabBarHeight ) style:UITableViewStylePlain];
        
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = RowHeight;
        tableView.tableHeaderView = fastView;
        tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageWithUIColor:UIColor.redColor]];
        self.tableView = tableView;
        tableView;
    });
    
    //inti headView
    UIView *headView =
    ({
        /**这是一个投机取巧的做法，让headView包裹着真正的HeaderInSection ，这个view会挡住全部餐厅，而这部分正好是导航栏的高度*/
        
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, HeaderBarHeight)];
        ACHFirstHeadView *firstHeadView = [ACHFirstHeadView firstHeadView];
        firstHeadView.frame = CGRectMake(0, HeaderBarHeight - firstHeadView.ACheight, SCRENNBOUNDS.size.width, firstHeadView.ACheight);
        [headView addSubview:firstHeadView];
        self.headView = headView;
        headView;
    });
    
    [self.view addSubview:tableView];
    [self.view addSubview:headView];
    
}

#pragma mark - ACHFastViewDelegate
/****************************************************************************************************************/

/**
 * 将跳转到指定的控制器
 */

-(void)didFastViewJumpView:(ACHFastViewJumpView *)view FirstButtonClip:(ACHButton *)btn
{
    //跳转到新手界面
    ACHFastNewHandVC *newHandVC = [[ACHFastNewHandVC alloc]init];
    [self.navigationController pushViewController:newHandVC animated:YES];
}
/**当FastViewJumpView的FirstButton被点击时调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view CutDownButtonClip:(ACHButton *)btn
{
    
    //跳转到砍价界面
    ACHCutDownVC *cutDownVC = [[ACHCutDownVC alloc]init];
    
    [self.navigationController pushViewController:cutDownVC animated:YES];
}


/**当FastViewJumpView的FirstButton被点击时调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view BrandButtonClip:(ACHButton *)btn
{
    //跳转到品牌界面
    ACHBrandVC *brandVC = [[ACHBrandVC alloc]init];
    
    [self.navigationController pushViewController:brandVC animated:YES];
}

/**当FastViewJumpView的FirstButton被点击时调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view DelicacyButtonClip:(ACHButton *)btn
{
    //跳转到有好菜
    [self.tabBarController setSelectedIndex:1];
}

@end
