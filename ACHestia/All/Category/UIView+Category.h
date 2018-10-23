//
//  UIView+frame.h
//  ACHestia
//
//  Created by Acery on 2018/10/16.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Category)

#pragma mark - set frame
/****************************************************************************************************************/

@property (assign, nonatomic) CGFloat ACx;

@property (assign, nonatomic) CGFloat ACy;

@property (assign, nonatomic) CGFloat ACwidth;

@property (assign, nonatomic) CGFloat ACheight;

#pragma mark - view copy
/****************************************************************************************************************/

/**以对象序列化的方式拷贝view -- 可以c写入NSObject的分类中*/
- (UIView*)copyFromView:(UIView*)view;


@end

NS_ASSUME_NONNULL_END
