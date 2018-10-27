//
//  CALayer+ACH.m
//  ACHestia
//
//  Created by Acery on 2018/10/27.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "CALayer+ACH.h"

@implementation CALayer (ACH)


+(instancetype)layerWithMaskImageName:(NSString *)imageName Frame:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    
    return imageView.layer;
}

+(instancetype)layerWithMaskImage:(UIImage *)image Frame:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = image;
    
    return imageView.layer;
}



@end
