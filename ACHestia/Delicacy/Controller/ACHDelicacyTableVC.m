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

//viewController
#import "ACHDelicacyDetailVC.h"


//item
#import "ACHDelicacyTableVCCellItem.h"

//define

#define TableViewHeaderHeight 60
#define RowHeight 250
#define TableViewOtherHeaderHeight 20


@interface ACHDelicacyTableVC () <UITableViewDelegate,UITableViewDataSource,ACHDelicacyTableSectionHeaderViewDelegate>


@property (nonatomic, strong) NSArray<NSArray<ACHDelicacyTableVCCellItem *> *> *group;

@property (nonatomic, weak) ACHDelicacyTableSectionHeaderView *tableSectionHeaderView;

@property (nonatomic, weak) UIView *tableSectionHeaderViewContentView;

@property (nonatomic, weak) ACHDelicacyTableSectionHeaderView *realSectionHeaderView;

@property (nonatomic, weak) UIView *tableHeaderView;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ACHDelicacyTableVC


{
    NSString *Identifier;
    
    CGFloat HeaderInSectionOne;
//    CGFloat HeaderInSectionTwo;
//    CGFloat HeaderInSectionThree;
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
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    
    return _tableView;
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
    self.navigationItem.title = @"有好菜";
    
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
