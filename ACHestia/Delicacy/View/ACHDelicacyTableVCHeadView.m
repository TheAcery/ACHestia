//
//  ACHDelicacyTableVCHeadView.m
//  ACHestia
//
//  Created by Acery on 2018/10/19.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHDelicacyTableVCHeadView.h"
#import "ACHScrollView.h"

#define SubViewsConut 3

@interface ACHDelicacyTableVCHeadView ()

@property (weak, nonatomic) IBOutlet ACHScrollView *scrollView;


@end

@implementation ACHDelicacyTableVCHeadView

+(instancetype)delicacyTableVCHeadView
{
    return [[NSBundle mainBundle]loadNibNamed:@"ACHDelicacyTableVCHeadView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.ACwidth = SCRENNBOUNDS.size.width;
    self.scrollView.ACwidth = SCRENNBOUNDS.size.width;// -------------------
    [self setNeedsLayout];
    
    [self makeViews];
}

-(void)makeViews
{
    
    NSMutableArray *views = [NSMutableArray array];
    for (int subViewsConut = 0; subViewsConut < SubViewsConut; subViewsConut++)
        
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(subViewsConut * SCRENNBOUNDS.size.width, 0, SCRENNBOUNDS.size.width, self.scrollView.ACheight)];
        imageView.image = [UIImage imageNamed:@"ORIimage"];
        
        [views addObject:imageView];
        
    }
    
    self.scrollView.views = views;
}


@end
