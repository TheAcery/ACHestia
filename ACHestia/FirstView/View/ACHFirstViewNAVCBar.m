//
//  ACHFirstViewNAVCBar.m
//  ACHestia
//
//  Created by Acery on 2018/10/20.
//  Copyright © 2018年 Acery. All rights reserved.
//  自定义的导航栏，提供标题左右barButton的设置接口，内部封装了UINavigationItem

#import "ACHFirstViewNAVCBar.h"

@interface ACHFirstViewNAVCBar ()

@property (nonatomic, strong) NSString *title;

@property (nonatomic, weak) UINavigationItem *item;

@end

@implementation ACHFirstViewNAVCBar

#pragma mark - init funs
/****************************************************************************************************************/

+(instancetype)FirstViewNAVCBarWithTitle:(NSString *)title
{
    ACHFirstViewNAVCBar *bar = [[ACHFirstViewNAVCBar alloc]initWithTitle:title];
    return bar;
}

-(instancetype)initWithTitle:(NSString *)title
{
    if (self = [self init])
    {
        [self addItmsWithTitle:title];
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self = [[NSBundle mainBundle]loadNibNamed:@"ACHFirstViewNAVCBar" owner:nil options:nil].firstObject;
        [self setShadowImage:[[UIImage alloc]init]];
    }
    return self;
}


#pragma mark - funs
/****************************************************************************************************************/

-(void)addItmsWithTitle:(NSString *)title
{
    UINavigationItem *item = [[UINavigationItem alloc]initWithTitle:title];
    self.item = item;
    
    NSArray *items = @[item];
    
    self.items = items;
}


#pragma mark - set funs
/****************************************************************************************************************/

- (void)setLeftItem:(UIBarButtonItem *)leftItem
{
    _leftItem = leftItem;
    self.item.leftBarButtonItem = leftItem;
    
}

- (void)setLeftItems:(NSArray<UIBarButtonItem *> *)leftItems
{
    _leftItems = leftItems;
    self.item.leftBarButtonItems = leftItems;
}

- (void)setRightItem:(UIBarButtonItem *)rightItem
{
    _rightItem = rightItem;
    self.item.rightBarButtonItem = rightItem;
}

- (void)setRightItems:(NSArray<UIBarButtonItem *> *)rightItems
{
    _rightItems = rightItems;
    self.item.rightBarButtonItems = rightItems;
}
@end
