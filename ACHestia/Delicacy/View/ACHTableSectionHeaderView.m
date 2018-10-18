//
//  ACHTableSectionHeaderView.m
//  ACHestia
//
//  Created by Acery on 2018/10/18.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHTableSectionHeaderView.h"

@implementation ACHTableSectionHeaderView

+(instancetype)tableSectionHeaderView
{
    return [[NSBundle mainBundle]loadNibNamed:@"ACHTableSectionHeaderView" owner:nil options:nil].firstObject;
}

@end
