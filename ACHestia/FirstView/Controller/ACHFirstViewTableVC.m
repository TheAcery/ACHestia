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

#define FASTVIEWHIGHT 300.0

@interface ACHFirstViewTableVC () <UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ACHFirstViewTranslationAnimtor *Animtor;

@property (nonatomic, weak) UITableView *tableView;

/**一直在屏幕顶部的view*/
@property (nonatomic, weak) UIView *headView;

/**在tableview前面的view*/
@property (nonatomic, weak) ACHFastView *fastView;

@end

@implementation ACHFirstViewTableVC

{
    NSString *Identifier;
}


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
    
    Identifier = @"cell";
    
    //init fastView
    UIView *fastView =
    ({
        ACHFastView *fastView = [ACHFastView fastView];
        self.fastView = fastView;
        fastView;
    });
    
    //init tableView
    UITableView *tableView =
    ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCRENNBOUNDS.size.width, SCRENNBOUNDS.size.height - 49 + 20) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 100;
        tableView.tableHeaderView = fastView;
        tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageWithUIColor:UIColor.redColor]];
        self.tableView = tableView;
        tableView;
    });
    
    //inti headView
    UIView *headView =
    ({
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, 70)];
        ACHFirstHeadView *firstHeadView = [ACHFirstHeadView firstHeadView];
        firstHeadView.ACy = 20;
        [headView addSubview:firstHeadView];
        self.headView = headView;
        headView;
    });
    
    
    [self.view addSubview:tableView];
    [self.view addSubview:headView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.delegate = nil;
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
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120;
}

#pragma mark -UITableViewDelegate
/****************************************************************************************************************/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = UIColor.redColor;
    
    self.navigationController.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController setNavigationBarHidden:NO];
    
}


#pragma mark - UIScrollViewDelegate
/****************************************************************************************************************/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat alpha = 1 - (scrollView.contentOffset.y/ (-20));

    self.headView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:alpha];
    //e设置 sectionHeadView 的阴影
}

#pragma mark - UINavigationControllerDelegate
/****************************************************************************************************************/


//设置转场动画
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop)
    {
        return self.Animtor;
    }
    
    return nil;
}
@end
