//
//  ACHFirstHeadView.m
//  ACHestia
//
//  Created by Acery on 2018/10/17.
//  Copyright © 2018年 Acery. All rights reserved.
//

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
