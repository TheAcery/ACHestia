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


//item
#import "ACHDelicacyTableVCCellItem.h"

//define

#define TableViewHeaderHeight 60

@interface ACHDelicacyTableVC () <UITableViewDelegate,UITableViewDataSource,ACHDelicacyTableSectionHeaderViewDelegate>

@property (nonatomic, strong) NSArray<NSArray *> *group;

@property (nonatomic, weak) ACHDelicacyTableSectionHeaderView *tableSectionHeaderView;

@property (nonatomic, weak) ACHDelicacyTableSectionHeaderView *realSectionHeaderView;

@property (nonatomic, weak) UIView *tableHeaderView;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ACHDelicacyTableVC


{
    NSString *Identifier;
    
    CGFloat HeaderInSectionOne;
    CGFloat HeaderInSectionTwo;
    CGFloat HeaderInSectionThree;
}

#pragma mark - lazy init
/****************************************************************************************************************/

//初始化组头视图
- (ACHDelicacyTableSectionHeaderView *)tableSectionHeaderView
{
    if (_tableSectionHeaderView == nil)
    {
        //创建tableSectionHeaderView的占位视图
        UIView *tableSectioncontainerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCRENNBOUNDS.size.width, TableViewHeaderHeight)];
//        tableSectioncontainerView.alpha = 0.0;
        [self.view addSubview:tableSectioncontainerView];
        
        //创建tableSectionHeaderView
        ACHDelicacyTableSectionHeaderView *headView = [ACHDelicacyTableSectionHeaderView tableSectionHeaderView];
        headView.delegate = self;
        headView.frame = tableSectioncontainerView.bounds;
        [tableSectioncontainerView addSubview:headView];
        
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
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, SCRENNBOUNDS.size.height - 49 ) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 250;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    
    return _tableView;
}


#pragma mark - ViewLoad funs
/****************************************************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    //set title
    [self setUp];
    //set subViews
    
    
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


#pragma mark - Delegate
/****************************************************************************************************************/


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        ACHDelicacyTableSectionHeaderView *sectionHeaderView = [ACHDelicacyTableSectionHeaderView tableSectionHeaderView];
        sectionHeaderView.delegate = self;
        
        self.realSectionHeaderView = sectionHeaderView;
        sectionHeaderView.frame = CGRectMake(0, 0, SCRENNBOUNDS.size.width, 50);

        return sectionHeaderView;
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, 20)];
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
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /**每次滚动计算*/
    HeaderInSectionOne = [self.tableView rectForHeaderInSection:0].origin.y - 64;
    HeaderInSectionTwo = [self.tableView rectForHeaderInSection:1].origin.y - 64 - TableViewHeaderHeight;
    HeaderInSectionThree = [self.tableView rectForHeaderInSection:2].origin.y - 64 - TableViewHeaderHeight;
    
    if (scrollView.contentOffset.y >= HeaderInSectionOne)
    {
        
        self.tableSectionHeaderView.alpha = 1.0;
        
        CGRect tableViewHeadRect = [self.view convertRect:CGRectMake(0, 64 + TableViewHeaderHeight, 375, 250) toView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathsForRowsInRect:tableViewHeadRect].firstObject;
        NSInteger section = indexPath.section;
        
        [self.tableSectionHeaderView buttonScroll:section];
        

    }
    else
    {
        self.tableSectionHeaderView.alpha = 0.0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = UIColor.redColor;
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - ACHDelicacyTableSectionHeaderViewDelegate
/****************************************************************************************************************/


- (void)didDelicacyTableSectionHeaderViewButtonClip:(ACHButton *)btn WithIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y - 40)  animated:NO];
}

@end
