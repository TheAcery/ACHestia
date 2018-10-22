//
//  ACHFirstHeadView.m
//  ACHestia
//
//  Created by Acery on 2018/10/17.
//  Copyright © 2018年 Acery. All rights reserved.
//  用XIB描述了ACHFirstHeadView ，这个view始终处于ACHFirstViewTableView的顶部

#import "ACHFirstHeadView.h"

@implementation ACHFirstHeadView

+(instancetype)firstHeadView
{
    return [[NSBundle mainBundle]loadNibNamed:@"ACHFirstHeadView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
     self.bounds = CGRectMake(0, 0, SCRENNBOUNDS.size.width, self.ACheight);
}

@end
