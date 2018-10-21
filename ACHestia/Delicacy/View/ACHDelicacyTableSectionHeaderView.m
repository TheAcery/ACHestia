//
//  ACHTableSectionHeaderView.m
//  ACHestia
//
//  Created by Acery on 2018/10/18.
//  Copyright © 2018年 Acery. All rights reserved.
//  描述始终处于ACHDelicacyTableVC顶部的导航视图，指示了TableVC当前滚动的位置同时还有快速滚动到指定位置的功能

#import "ACHDelicacyTableSectionHeaderView.h"


@interface ACHDelicacyTableSectionHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *indexSuperView;

@property (weak, nonatomic) IBOutlet UIStackView *stackView;

/**按钮之前的间距 50*/
@property (weak, nonatomic) IBOutlet ACHButton *oneButton;
@property (weak, nonatomic) IBOutlet ACHButton *twoButton;
@property (weak, nonatomic) IBOutlet ACHButton *threeButton;

/**保存按钮的数组*/

@property (nonatomic, strong) NSMutableArray *buttonArray;


@property (assign, nonatomic) NSInteger offSetY;

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
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.oneButton.ACwidth, 5)];
    subView.backgroundColor = UIColor.yellowColor;
    [self.indexSuperView addSubview:subView];
}

/**为所有的按钮添加target*/
-(void)addButtonAction
{
    [self.oneButton addTarget:self action:@selector(buttonClip:) forControlEvents:UIControlEventTouchUpInside];
    [self.twoButton addTarget:self action:@selector(buttonClip:) forControlEvents:UIControlEventTouchUpInside];
    [self.threeButton addTarget:self action:@selector(buttonClip:) forControlEvents:UIControlEventTouchUpInside];
}

/**在这个方法中移动indexView，实际上每次更改的是indexSuperView的fbounds的x值*/
-(void)moveIndexView:(CGFloat)boundsX
{
    [UIView animateWithDuration:0.3 animations:^{
        self.indexSuperView.bounds = CGRectMake(boundsX, 0, self.indexSuperView.bounds.size.width, self.indexSuperView.bounds.size.height);
    } completion:nil];
}

#pragma mark - action
/****************************************************************************************************************/

/**
 
 * 1.取出调用buttonClip:按钮的index。
 
 * 2.传入buttonScroll:以滚动idnexView。
 
 * 3.抛出时间让ACHDelicacyTableVC滚动到指定的组。
 
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
    [self moveIndexView:index * (- self.stackView.spacing - self.oneButton.ACwidth)];
}

@end
