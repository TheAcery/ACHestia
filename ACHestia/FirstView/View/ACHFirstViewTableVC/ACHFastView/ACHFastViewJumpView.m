//
//  ACHFastViewJumpView.m
//  ACHestia
//
//  Created by Acery on 2018/10/23.
//  Copyright © 2018年 Acery. All rights reserved.
//  ACHFastView跳转按钮的视图

#import "ACHFastViewJumpView.h"



@interface ACHFastViewJumpView ()

/**跳转到新手指南*/
@property (weak, nonatomic) IBOutlet ACHButton *firstButton;

/**跳转到砍价*/
@property (weak, nonatomic) IBOutlet ACHButton *cutDownButton;

/**跳转到新品牌*/
@property (weak, nonatomic) IBOutlet ACHButton *brandButton;

/**跳转到有好菜*/
@property (weak, nonatomic) IBOutlet ACHButton *delicacyButton;

@end

@implementation ACHFastViewJumpView

+(instancetype)fastViewJumpView
{
    return [[ACHFastViewJumpView alloc]init];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[NSBundle mainBundle]loadNibNamed:@"ACHFastViewJumpView" owner:nil options:nil].firstObject;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self addSubViewTarget];
}


#pragma mark - fun
/****************************************************************************************************************/

-(void)addSubViewTarget
{
    [self.firstButton addTarget:self action:@selector(firstButtonClip:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.cutDownButton addTarget:self action:@selector(cutDownButtonClip:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.brandButton addTarget:self action:@selector(brandButtonClip:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.delicacyButton addTarget:self action:@selector(delicacyButtonClip:) forControlEvents:UIControlEventTouchUpInside];
}



#pragma mark - action
/****************************************************************************************************************/

/**
 * 这些action fun 在被调用的时候将事件抛出，传递到ACHFastView ->  ACHFirstViewTableVC
 */

/**在firstButton点击到时候调用*/
-(void)firstButtonClip:(ACHButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(didFastViewJumpView:FirstButtonClip:)])
    {
        [self.delegate didFastViewJumpView:self FirstButtonClip:btn];
    }
}

/**在cutDownButton点击到时候调用*/
-(void)cutDownButtonClip:(ACHButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(didFastViewJumpView:CutDownButtonClip:)])
    {
        [self.delegate didFastViewJumpView:self CutDownButtonClip:btn];
    }
}

/**在randButton点击到时候调用*/
-(void)brandButtonClip:(ACHButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(didFastViewJumpView:BrandButtonClip:)])
    {
        [self.delegate didFastViewJumpView:self BrandButtonClip:btn];
    }
}

/**在delicacyButton点击到时候调用*/
-(void)delicacyButtonClip:(ACHButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(didFastViewJumpView:DelicacyButtonClip:)])
    {
        [self.delegate didFastViewJumpView:self DelicacyButtonClip:btn];
    }
}



@end
