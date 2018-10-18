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
#import "ACHTableSectionHeaderView.h"


//item
#import "ACHDelicacyTableVCCellItem.h"

//define

#define TableViewHeaderHeight 50

@interface ACHDelicacyTableVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSArray *> *group;

@property (nonatomic, weak) UIView *tableSectionHeaderView;

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
- (UIView *)tableSectionHeaderView
{
    if (_tableSectionHeaderView == nil)
    {
        UIView *tableSectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, TableViewHeaderHeight)];
        tableSectionHeaderView.alpha = 0.0;
        [self.view addSubview:tableSectionHeaderView];
        
        ACHTableSectionHeaderView *headView = [ACHTableSectionHeaderView tableSectionHeaderView];
        headView.frame = tableSectionHeaderView.bounds;
        
        [tableSectionHeaderView addSubview:headView];
        
        _tableSectionHeaderView = tableSectionHeaderView;
    }
    
    return _tableSectionHeaderView;
}

//初始化列表头视图
- (UIView *)tableHeaderView
{
    if (_tableHeaderView == nil)
    {
        UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, 200)];
        tableHeaderView.backgroundColor = UIColor.yellowColor;
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
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, SCRENNBOUNDS.size.height - 64 - 49) style:UITableViewStylePlain];
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


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    HeaderInSectionOne = [self.tableView rectForHeaderInSection:0].origin.y;
    HeaderInSectionTwo = [self.tableView rectForHeaderInSection:1].origin.y;
    HeaderInSectionThree = [self.tableView rectForHeaderInSection:2].origin.y;
    
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
            
            for (int itemsCount = 0; itemsCount < 3; itemsCount++)
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
    NSArray *items = self.group[indexPath.section];
    ACHDelicacyTableVCCellItem *item = items[indexPath.row];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - Delegate
/****************************************************************************************************************/


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {

        return [ACHTableSectionHeaderView tableSectionHeaderView];
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


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    //让第一组的header一只保持，同时划过第二组的时候更新header，并非替换
    //创建自己的view代替header ----> 在划到第一组的时候显示header,把这个header放入tableviewheader
    NSLog(@"dispaly");
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section

{

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
#warning TODO 怎样确定滚动到每个header

    if (scrollView.contentOffset.y >= HeaderInSectionOne)
    {
        self.tableSectionHeaderView.alpha = 1.0;
        
        if (scrollView.contentOffset.y >= HeaderInSectionOne && scrollView.contentOffset.y < HeaderInSectionTwo)//处于1
        {
            
        }
        
        if (scrollView.contentOffset.y >= HeaderInSectionTwo && scrollView.contentOffset.y < HeaderInSectionThree)//处于2
        {
            
        }
       if (scrollView.contentOffset.y >= HeaderInSectionThree)//处于3
        {
            
        }
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
@end
