//
//  ACHTableSectionHeaderView.m
//  ACHestia
//
//  Created by Acery on 2018/10/18.
//  Copyright © 2018年 Acery. All rights reserved.
//  描述始终处于ACHDelicacyTableVC顶部的导航视图，指示了TableVC当前滚动的位置同时还有快速滚动到指定位置的功能

#import "ACHDelicacyTableSectionHeaderView.h"

/**更改滑块和按钮选中的颜色*/
#define TintColor  UIColor.redColor


@interface ACHDelicacyTableSectionHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *indexSuperView;

@property (weak, nonatomic) IBOutlet UIStackView *stackView;

/**按钮之前的间距 50*/
@property (weak, nonatomic) IBOutlet ACHButton *oneButton;
@property (weak, nonatomic) IBOutlet ACHButton *twoButton;
@property (weak, nonatomic) IBOutlet ACHButton *threeButton;

/**保存按钮的数组*/

@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (assign, nonatomic) ACHButton *nowButton;

@property (assign, nonatomic) ACHButton *lastButton;

@property (assign, nonatomic) NSInteger offSetY;

@property (assign, nonatomic) CGFloat buttonLableDistance;

@end

@implementation ACHDelicacyTableSectionHeaderView

#pragma mark - init funs
/****************************************************************************************************************/

+(instancetype)tableSectionHeaderView
{
    return [[NSBundle mainBundle]loadNibNamed:@"ACHDelicacyTableSectionHeaderView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //重新确定大小
    self.ACwidth = SCRENNBOUNDS.size.width;
    
    [self addIndexView];
    
    [self addButtonAction];
    
}


#pragma mark - lazy init
/****************************************************************************************************************/

- (NSMutableArray *)buttonArray
{
    if (_buttonArray == nil)
    {
        _buttonArray = [NSMutableArray array];
        //add buttons
        [_buttonArray addObject:self.oneButton];
        [_buttonArray addObject:self.twoButton];
        [_buttonArray addObject:self.threeButton];
    }
    
    return _buttonArray;
}


#pragma mark - funs
/****************************************************************************************************************/

/**添加indexView*/
-(void)addIndexView
{
    [self.oneButton layoutSubviews];
    self.buttonLableDistance = self.oneButton.titleLabel.ACx;
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(self.buttonLableDistance, 0, self.oneButton.titleLabel.ACwidth, 5)];
    subView.backgroundColor = TintColor;
    [self.indexSuperView addSubview:subView];
    
    self.lastButton = self.oneButton;
    //选中第一个按钮
    self.oneButton.selected = YES;
}

/**为所有的按钮添加target*/
-(void)addButtonAction
{
    [self.oneButton addTarget:self action:@selector(buttonClip:) forControlEvents:UIControlEventTouchUpInside];
    [self.oneButton setTitleColor:TintColor forState:UIControlStateSelected];
    
    [self.twoButton addTarget:self action:@selector(buttonClip:) forControlEvents:UIControlEventTouchUpInside];
    [self.twoButton setTitleColor:TintColor forState:UIControlStateSelected];
    
    [self.threeButton addTarget:self action:@selector(buttonClip:) forControlEvents:UIControlEventTouchUpInside];
    [self.threeButton setTitleColor:TintColor forState:UIControlStateSelected];
    
}

/**在这个方法中移动indexView，实际上每次更改的是indexSuperView的fbounds的x值*/
-(void)moveIndexView:(CGFloat)boundsX
{
   
    
    [UIView animateWithDuration:0.3 animations:^{
        self.indexSuperView.bounds = CGRectMake(boundsX, 0, self.indexSuperView.bounds.size.width, self.indexSuperView.bounds.size.height);
    } completion:^(BOOL finished){
        
        //上次选中的按钮取消选中
        self.lastButton.selected = NO;
        //获取当前按钮
        self.nowButton.selected = YES;
        //让当前按钮选中
        
        //赋值上次的按钮
        self.lastButton = self.nowButton;
        
    }];
    
    
}

#pragma mark - action
/****************************************************************************************************************/

/**
 
 * 1.取出调用buttonClip:按钮的index。
 
 * 2.传入buttonScroll:以滚动idnexView。
 
 * 3.抛出事件让ACHDelicacyTableVC滚动到指定的组。
 
 */

-(void)buttonClip:(ACHButton *)btn
{
    
    NSInteger index = [self.buttonArray indexOfObject:btn];
    
    
    [self buttonScroll:index];

    if ([self.delegate respondsToSelector:@selector(didDelicacyTableSectionHeaderViewButtonClip:WithIndex:)])
    {
        [self.delegate didDelicacyTableSectionHeaderViewButtonClip:btn WithIndex:index];
    }
}


#pragma mark - funs
/****************************************************************************************************************/

/**根据传入的index计算indexView最终滚动的位置，并把结果传入moveIndexView以滚动*/
-(void)buttonScroll:(NSInteger)index
{
    self.nowButton = [self.buttonArray objectAtIndex:index];
    
    [self moveIndexView:index * -(self.buttonLableDistance * 2 + self.stackView.spacing + self.oneButton.titleLabel.ACwidth)];
}

@end
