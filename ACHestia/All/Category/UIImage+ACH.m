//
//  UIImage+ACH.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//  UIImage的分类

#import "UIImage+ACH.h"

@implementation UIImage (ACH)

+(UIImage *)UNRenderimageNamed:(NSString *)name;
{
    UIImage *image = [UIImage imageNamed:name];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

+(UIImage *)imageWithUIColor:(UIColor *)color
{
    UIGraphicsBeginImageContext(CGSizeMake(30, 30));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    view.backgroundColor = color;
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
