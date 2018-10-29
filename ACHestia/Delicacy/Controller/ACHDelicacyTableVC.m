//
//  ACHViewController.m
//  ACHestia
//
//  Created by Acery on 2018/10/16.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHDelicacyTableVC.h"

//view
#import "ACHDelicacyTableVCCell.h"
#import "ACHDelicacyTableSectionHeaderView.h"
#import "ACHDelicacyTableVCHeadView.h"
#import "ACHDownToUpDataView.h"

//viewController
#import "ACHDelicacyDetailVC.h"


//item
#import "ACHDelicacyTableVCCellItem.h"

//define

#define TableViewHeaderHeight 60
#define RowHeight 250
#define TableViewOtherHeaderHeight 20

#define DownToUpDataViewHeight 70
#define DownToUpDataBKViewHeight 50


@interface ACHDelicacyTableVC () <UITableViewDelegate,UITableViewDataSource,ACHDelicacyTableSectionHeaderViewDelegate>


@property (nonatomic, strong) NSArray<NSArray<ACHDelicacyTableVCCellItem *> *> *group;

@property (nonatomic, weak) ACHDelicacyTableSectionHeaderView *tableSectionHeaderView;

@property (nonatomic, weak) UIView *tableSectionHeaderViewContentView;

@property (nonatomic, weak) ACHDelicacyTableSectionHeaderView *realSectionHeaderView;

@property (nonatomic, weak) UIView *tableHeaderView;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) ACHDownToUpDataView *downToUpDataView;


/**是否取消更新*/
@property (assign, nonatomic) BOOL isupDataCancel;

/**是否正在更新*/
@property (assign, nonatomic) BOOL isUpData;

@end

@implementation ACHDelicacyTableVC


{
    NSString *Identifier;
    
    CGFloat HeaderInSectionOne;
    
}



#pragma mark - lazy init
/****************************************************************************************************************/

//初始化组头视图
- (ACHDelicacyTableSectionHeaderView *)tableSectionHeaderView
{
    if (_tableSectionHeaderView == nil)
    {
        //创建tableSectionHeaderView的占位视图
        UIView *tableSectioncontainerView = [[UIView alloc]initWithFrame:CGRectMake(0, HeaderBarHeight, SCRENNBOUNDS.size.width, TableViewHeaderHeight)];

        [self.view addSubview:tableSectioncontainerView];
        
        //创建tableSectionHeaderView
        ACHDelicacyTableSectionHeaderView *headView = [ACHDelicacyTableSectionHeaderView tableSectionHeaderView];
        headView.delegate = self;
        headView.frame = tableSectioncontainerView.bounds;
        [tableSectioncontainerView addSubview:headView];
        
        self.tableSectionHeaderViewContentView = tableSectioncontainerView;
        _tableSectionHeaderView = headView;
    }
    
    return _tableSectionHeaderView;
}

//初始化列表头视图
- (UIView *)tableHeaderView
{
    if (_tableHeaderView == nil)
    {
        ACHDelicacyTableVCHeadView *tableHeaderView = [ACHDelicacyTableVCHeadView delicacyTableVCHeadView];
        [self.tableView setTableHeaderView:tableHeaderView];
        
        _tableHeaderView = tableHeaderView;
    }
    return _tableHeaderView;
}

//初始化列表视图
- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, SCRENNBOUNDS.size.height - TabBarHeight ) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = RowHeight;
        tableView.backgroundColor = UIColor.clearColor;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    
    return _tableView;
}

- (ACHDownToUpDataView *)downToUpDataView
{
    if (_downToUpDataView == nil)
    {
        UIImageView *BKImageview = [[UIImageView alloc]initWithFrame:CGRectMake((SCRENNBOUNDS.size.width - DownToUpDataBKViewHeight)  * 0.5,DownToUpDataViewHeight - DownToUpDataBKViewHeight, DownToUpDataBKViewHeight, DownToUpDataBKViewHeight)];
        BKImageview.image = [UIImage imageNamed:@"updata_logo"];
        
        ACHDownToUpDataView *downToUpDataView = [ACHDownToUpDataView downToUpDataViewWithBKImageView:BKImageview];
        downToUpDataView.frame = CGRectMake(0, HeaderBarHeight, SCRENNBOUNDS.size.width, DownToUpDataViewHeight);
        
        [self.view addSubview:downToUpDataView];
        _downToUpDataView = downToUpDataView;
    }
    
    return _downToUpDataView;
}


#pragma mark - ViewLoad funs
/****************************************************************************************************************/

- (void)viewDidLoad
{
    [super viewDidLoad];
    //setUp
    [self setUp];
    //set subViews
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //计算tableSectionHeaderView 和 realSectionHeaderView交替的差值
    HeaderInSectionOne = [self.tableView rectForHeaderInSection:0].origin.y - HeaderBarHeight;
    
   
}

#pragma mark - lazy init
/****************************************************************************************************************/

- (NSArray<NSArray *> *)group
{
    if (_group == nil)
    {
        NSMutableArray *group = [NSMutableArray array];
        //请求数据
        //创建模型
        //添加到模型数组
        NSString *name;
        /**没有网络接口，使用本地的虚拟数据*/
        for (int groupCount = 0; groupCount < 3; groupCount++)
        {
            switch (groupCount) {
                case 0:
                    name = @"饭新品";
                    break;
                case 1:
                    name = @"饭当季";
                    break;
                case 2:
                    name = @"饭招牌";
                    break;
                default:
                    break;
            }
            NSMutableArray *items = [NSMutableArray array];
            
            for (int itemsCount = 0; itemsCount < 20; itemsCount++)
            {
                ACHDelicacyTableVCCellItem *item = [[ACHDelicacyTableVCCellItem alloc]init];
                [items addObject:item];
            }
            
            [group addObject:items];
        }
        

        _group = group;
    }
    
    return _group;
}

#pragma mark - funs
/****************************************************************************************************************/

/**初始化视图*/

-(void)setUp
{
    
    Identifier = @"cell";
    self.isupDataCancel = NO;
    self.isUpData = NO;
    
    self.navigationItem.title = @"有好菜";

    self.view.backgroundColor = UIColor.whiteColor;
    [self downToUpDataView];
    [self tableHeaderView];
    [self tableSectionHeaderView];

}


#pragma mark - UITableViewDataSource
/****************************************************************************************************************/


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.group.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *items = self.group[section];
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACHDelicacyTableVCCell  *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (cell == nil)
    {
        cell = [ACHDelicacyTableVCCell delicacyTableVCCell];
    }
    
    //get item

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - UITableViewDelegate
/****************************************************************************************************************/


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        ACHDelicacyTableSectionHeaderView *sectionHeaderView = [ACHDelicacyTableSectionHeaderView tableSectionHeaderView];
        sectionHeaderView.delegate = self;
        
        self.realSectionHeaderView = sectionHeaderView;
        return sectionHeaderView;
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, StatusBarHeight)];
    view.backgroundColor = UIColor.yellowColor;
    
    return view;
}



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return TableViewHeaderHeight;
    }
    return TableViewOtherHeaderHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0;
}

#pragma mark - UIScrollViewDelegate
/****************************************************************************************************************/


/**
 * 在tableView滚动时，判断tableSectionHeaderView和realSectionHeaderView时候重合，以及改变tableSectionHeaderView的indexView的位置
 * 在tableSectionHeaderView和realSectionHeaderView不需要重合的时候隐藏tableSectionHeaderView的的父视图，重合的时候让tableSectionHeaderView在realSectionHeaderView上面（覆盖）
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (scrollView.contentOffset.y >= HeaderInSectionOne)
    {
        
        /**
         * 如果单独隐藏tableSectionHeaderView在tableSectionHeaderView和realSectionHeaderView即将重合的时候它的父视图将会挡住realSectionHeaderView的点击事件。
         * 所以需要隐藏它的父视图tableSectionHeaderViewContentView。
         */
        
        self.tableSectionHeaderViewContentView.alpha = 1.0;
        
        CGRect tableViewHeadRect = [self.view convertRect:CGRectMake(0, HeaderBarHeight + TableViewHeaderHeight, SCRENNBOUNDS.size.width, RowHeight) toView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathsForRowsInRect:tableViewHeadRect].firstObject;
        NSInteger section = indexPath.section;
        
        [self.tableSectionHeaderView buttonScroll:section];
        
        if (section == 0)//复原realSectionHeaderView //让两个headViewa保持一致
        {
            [self.realSectionHeaderView buttonScroll:0];
        }
        
    }
    else
    {
        self.tableSectionHeaderViewContentView.alpha = 0.0;
    }
    
//    NSLog(@"---- %f",scrollView.contentOffset.y);
    
    //刷新判断
    if (scrollView.contentOffset.y <= -HeaderBarHeight)//当y偏移量小于0是，可能在刷新
    {
        

        
        if (scrollView.contentOffset.y <= -DownToUpDataViewHeight - HeaderBarHeight)//当偏移量小于0的部分超过downToUpDataView的h高度时，downToUpDataView应该跟随移动
        {
            self.downToUpDataView.ACy = - scrollView.contentOffset.y - DownToUpDataViewHeight;
        }
        
        if (scrollView.contentOffset.y > -DownToUpDataViewHeight - HeaderBarHeight && self.isUpData)//当正在更新，一上拉就取消更新
        {
            //更新被取消
            self.isupDataCancel = YES;
            //结束动画
            [self.downToUpDataView cancelAnimate];
            //不再不在更新
            self.isUpData = NO;
            
            
            [UIView animateWithDuration:0.5 animations:^{
                
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                scrollView.contentOffset = CGPointMake(0, - HeaderBarHeight);
            }];
            
            
            NSLog(@"cancel");
        }
        if (scrollView.contentOffset.y <= -DownToUpDataViewHeight - HeaderBarHeight && _isUpData)
        {
            //更新被取消
            self.isupDataCancel = NO;
            
        }
    }
    else
    {
        //没在更新
        NSLog(@"not");
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //判断是否下拉刷新
    if (scrollView.contentOffset.y <= -DownToUpDataViewHeight - HeaderBarHeight && !self.isUpData)
    {
        self.isUpData = YES;
        //开始刷新动画
        [self.downToUpDataView startAnimate];
        scrollView.contentInset = UIEdgeInsetsMake(DownToUpDataViewHeight, 0, 0, 0);
        
        //模拟网络请求的延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                if (!self.isupDataCancel)
                {
                    
                    [scrollView.panGestureRecognizer setTranslation:CGPointZero inView:scrollView.panGestureRecognizer.view];
                    //在每次更新完成之后结束上一次的手势
                    scrollView.panGestureRecognizer.state = UIGestureRecognizerStateEnded;
//                    self.headView.ACy = 0;
                    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                    scrollView.contentOffset = CGPointMake(0, - HeaderBarHeight);
                    
                    self.downToUpDataView.ACy = HeaderBarHeight;
                    
                    
                    
                }
                //结束动画
                [self.downToUpDataView cancelAnimate];
                self.isUpData = NO;
            }];
            
        });
    }
}


/**
 * 点击cell的时候跳转到其他控制器
 */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACHDelicacyDetailVC *vc = [[ACHDelicacyDetailVC alloc]init];
    
   
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - ACHDelicacyTableSectionHeaderViewDelegate
/****************************************************************************************************************/

/**
 * 当SectionHeaderView上的button被点击时调用，在这个方法中让tableView滚动到指定的位置
 * 第一次点击的是realSectionHeaderView，没有赋值第一次的lastButton
 */

- (void)didDelicacyTableSectionHeaderViewButtonClip:(ACHButton *)btn WithIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    if (index != 0) {
        [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y - (TableViewHeaderHeight - TableViewOtherHeaderHeight) )  animated:NO];
    }
}

@end
