//
//  ACHFirstViewTableHeadView.m
//  ACHestia
//
//  Created by Acery on 2018/10/17.
//  Copyright © 2018年 Acery. All rights reserved.
// ACHFirstViewTable的HeadView

#import "ACHFirstViewTableHeadView.h"

@implementation ACHFirstViewTableHeadView

+(instancetype)firstViewTableHeadView
{
    return [[NSBundle mainBundle]loadNibNamed:@"ACHFirstViewTableHeadView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.bounds = CGRectMake(0, 0, SCRENNBOUNDS.size.width, self.ACheight);
}

@end
