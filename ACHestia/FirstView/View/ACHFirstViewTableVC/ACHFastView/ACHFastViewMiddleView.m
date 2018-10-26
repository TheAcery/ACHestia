//
//  ACHFastViewMiddleView.m
//  ACHestia
//
//  Created by Acery on 2018/10/23.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHFastViewMiddleView.h"

@implementation ACHFastViewMiddleView

+(instancetype)fastViewMiddleView
{
    return [[ACHFastViewMiddleView alloc]init];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[NSBundle mainBundle]loadNibNamed:@"ACHFastViewMiddleView" owner:nil options:nil].firstObject;
    }
    return self;
}

@end
