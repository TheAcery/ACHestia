//
//  ACHFirstViewTableVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//

/**
 * 这个控制器是ACHFirstView的根控制器，描述了很多的逻辑
 * 下拉更新逻辑
 * 按钮点击的控制器跳转逻辑，这个很简单，只要将事件从视图中抛出，然后在对应的事件触发时跳转控制器就行
 */

/** --- 下拉更新逻辑
 * 下拉刷新逻辑，tableView拖拽停止的时候来判断是否应该更新，在tableView滚动偏移量小于0的时候让headView进行移动
 * 在更新的时候假如向上拖拽来tableView，这时候应该取消更新，包括动画和网络请求，这时候偏移量的区间应该是0 到 -downToUpDataView.height，同时还应该满足正在更新的状态，，因为在每次下拉更新的时候都会在这个区间滚动。这个标示应该开开始更新的时候设为yes，在结束和取消的时候设为no
 * 在正常更新结束后我们吧内边距的top设置为0、停止请求、停止动画、让headView回来最开始的位置，同样的我们在取消的时候也希望这样
 */

#import "ACHFirstViewTableVC.h"
#import "ACHFirstViewTranslationAnimtor.h"

//view
#import "ACHFastView.h"
#import "ACHFirstViewTableHeadView.h"
#import "ACHFirstHeadView.h"
#import "ACHFirstViewTableViewCell.h"
#import "ACHDownToUpDataView.h"

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

/**下拉刷新视图*/
@property (nonatomic, weak) ACHDownToUpDataView *downToUpDataView;

@end

@implementation ACHFirstViewTableVC


NSString  *Identifier  = @"cell";

/**是否取消更新*/
bool isupDataCancel = NO;

/**是否正在更新*/
bool isUpData = NO;



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
    self.view.backgroundColor = UIColor.whiteColor;

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
    
    //刷新判断
    if (scrollView.contentOffset.y <= 0)//当y偏移量小于0是，可能在刷新
    {
        
        self.headView.ACy = -scrollView.contentOffset.y;
        
        if (scrollView.contentOffset.y <= -70)//当偏移量小于0的部分超过downToUpDataView的h高度时，downToUpDataView应该跟随移动
        {
            self.downToUpDataView.ACy = - scrollView.contentOffset.y - 70;
        }
        
        if (scrollView.contentOffset.y > -70 && isUpData)//当正在更新，一上拉就取消更新
        {
            //更新被取消
            isupDataCancel = YES;
            //结束动画
            [self.downToUpDataView cancelAnimate];
            //不再不在更新
            isUpData = NO;
           
        }
        if (scrollView.contentOffset.y == -70 && isUpData)
        {
            //更新被取消
            isupDataCancel = NO;
        }
    }
    else
    {
        //没在更新
        self.headView.ACy = 0;
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    self.headView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:alpha];
    //设置 sectionHeadView 的阴影
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //判断是否下拉刷新
    if (scrollView.contentOffset.y <= -70)
    {
        isUpData = YES;
        //开始刷新动画
        [self.downToUpDataView startAnimate];
        scrollView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
        
        //模拟网络请求的延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                if (!isupDataCancel)
                {
                    self.headView.ACy = scrollView.contentOffset.y;
                    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                }
                //结束动画
                [self.downToUpDataView cancelAnimate];
                isUpData = NO;
            }];
            
        });
    }
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
        tableView.backgroundColor = UIColor.clearColor;
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
    
    //down to updata view
    
    ACHDownToUpDataView *downToUpDataView =
    ({
        UIImageView *BKImageview = [[UIImageView alloc]initWithFrame:CGRectMake((SCRENNBOUNDS.size.width - 50)  * 0.5, 20, 50, 50)];
        BKImageview.image = [UIImage imageNamed:@"updata_logo"];
        
        ACHDownToUpDataView *downToUpDataView = [ACHDownToUpDataView downToUpDataViewWithBKImageView:BKImageview];
        downToUpDataView.frame = CGRectMake(0, 0, SCRENNBOUNDS.size.width, 70);
        self.downToUpDataView = downToUpDataView;
        downToUpDataView;
    });
    

    [self.view addSubview: downToUpDataView];
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
