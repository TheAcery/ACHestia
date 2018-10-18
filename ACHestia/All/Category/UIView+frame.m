//
//  UIView+frame.m
//  ACHestia
//
//  Created by Acery on 2018/10/16.
//  Copyright © 2018年 Acery. All rights reserved.
//  UIView的l分类

#import "UIView+frame.h"

@implementation UIView (frame)

#pragma mark - seting funs
/****************************************************************************************************************/

- (void)setACx:(CGFloat)ACx
{
    CGRect frame = self.frame;
    frame.origin.x = ACx;
    
    self.frame = frame;
}

- (void)setACy:(CGFloat)ACy
{
    CGRect frame = self.frame;
    frame.origin.y = ACy;
    
    self.frame = frame;
}

- (void)setACwidth:(CGFloat)ACwidth
{
    CGRect frame = self.frame;
    frame.size.width = ACwidth;
    
    self.frame = frame;
}

- (void)setACheight:(CGFloat)ACheight
{
    CGRect frame = self.frame;
    frame.size.height = ACheight;
    
    self.frame = frame;
}


#pragma mark - getting funs
/****************************************************************************************************************/

- (CGFloat)ACx
{
    return self.frame.origin.x;
}

- (CGFloat)ACy
{
    return self.frame.origin.y;
}

- (CGFloat)ACwidth
{
    return self.frame.size.width;
}

- (CGFloat)ACheight
{
    return self.frame.size.height;
}

@end
