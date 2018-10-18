//
//  ACHDelicacyTableVCCellShopDetail.m
//  ACHestia
//
//  Created by Acery on 2018/10/18.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHDelicacyTableVCCellShopDetail.h"

@implementation ACHDelicacyTableVCCellShopDetail

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self = [[NSBundle mainBundle]loadNibNamed:@"ACHDelicacyTableVCCellShopDetail" owner:nil options:nil].firstObject;
    }
    return self;
}

@end
