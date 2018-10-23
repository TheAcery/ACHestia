//
//  UIView+frame.m
//  ACHestia
//
//  Created by Acery on 2018/10/16.
//  Copyright © 2018年 Acery. All rights reserved.
//  UIView的l分类

#import "UIView+Category.h"

@implementation UIView (Category)

#pragma mark - frame -- setting funs
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


#pragma mark - frame -- getting funs
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



#pragma mark - view copy
/****************************************************************************************************************/

- (UIView*)copyFromView:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}
@end
