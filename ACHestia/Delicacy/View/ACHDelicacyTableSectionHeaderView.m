//
//  ACHTableSectionHeaderView.m
//  ACHestia
//
//  Created by Acery on 2018/10/18.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHDelicacyTableSectionHeaderView.h"

#warning TODO 重新创建传递titleIndexView位置的机制


@interface ACHDelicacyTableSectionHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *indexSuperView;

@property (weak, nonatomic) IBOutlet UIStackView *stackView;

/**按钮之前的间距 50*/
@property (weak, nonatomic) IBOutlet ACHButton *oneButton;
@property (weak, nonatomic) IBOutlet ACHButton *twoButton;
@property (weak, nonatomic) IBOutlet ACHButton *threeButton;


@property (assign, nonatomic) NSInteger offSetY;

@end

@implementation ACHDelicacyTableSectionHeaderView

+(instancetype)tableSectionHeaderView
{
    return [[NSBundle mainBundle]loadNibNamed:@"ACHDelicacyTableSectionHeaderView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self addScrollViewitems];
    
    [self addButtonAction];
}


#pragma mark - funs
/****************************************************************************************************************/

-(void)addScrollViewitems
{
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.oneButton.ACwidth, 5)];
    subView.backgroundColor = UIColor.yellowColor;
    [self.indexSuperView addSubview:subView];
}

-(void)addButtonAction
{
    [self.oneButton addTarget:self action:@selector(oneButtonClip) forControlEvents:UIControlEventTouchUpInside];
    [self.twoButton addTarget:self action:@selector(twoButtonClip) forControlEvents:UIControlEventTouchUpInside];
    [self.threeButton addTarget:self action:@selector(threeButtonClip) forControlEvents:UIControlEventTouchUpInside];
}

-(void)moveSubView:(CGFloat)boundsX
{
    [UIView animateWithDuration:0.3 animations:^{
        self.indexSuperView.bounds = CGRectMake(boundsX, 0, self.indexSuperView.bounds.size.width, self.indexSuperView.bounds.size.height);
    } completion:nil];
}

#pragma mark - action
/****************************************************************************************************************/


-(void)oneButtonClip
{
    [self scrollToOne];
    //cell delegate
    if ([self.delegate respondsToSelector:@selector(didDelicacyTableSectionHeaderViewOneButtonClip:)])
    {
        [self.delegate didDelicacyTableSectionHeaderViewOneButtonClip:self.oneButton];
    }
}

-(void)twoButtonClip
{
    [self scrollToTwo];
    //cell delegate
    if ([self.delegate respondsToSelector:@selector(didDelicacyTableSectionHeaderViewTwoButtonClip:)])
    {
        [self.delegate didDelicacyTableSectionHeaderViewTwoButtonClip:self.twoButton];
    }
    
    
}

-(void)threeButtonClip
{
    [self scrollToThree];
    //cell delegate
    if ([self.delegate respondsToSelector:@selector(didDelicacyTableSectionHeaderViewThreeButtonClip:)])
    {
        [self.delegate didDelicacyTableSectionHeaderViewThreeButtonClip:self.threeButton];
    }
}


#pragma mark - funs
/****************************************************************************************************************/

-(void)scrollToOne
{
    [self moveSubView:0];
    
    _titleIndexViewState = ACHDelicacyTableSectionHeaderTitleIndexViewInOne;
}

-(void)scrollToTwo
{
    [self moveSubView:(- self.stackView.spacing - self.oneButton.ACwidth)];
    
    _titleIndexViewState = ACHDelicacyTableSectionHeaderTitleIndexViewInTwo;
}

-(void)scrollToThree
{
    [self moveSubView:(- self.stackView.spacing - self.oneButton.ACwidth) * 2];
    
    _titleIndexViewState = ACHDelicacyTableSectionHeaderTitleIndexViewInThree;
}



@end
