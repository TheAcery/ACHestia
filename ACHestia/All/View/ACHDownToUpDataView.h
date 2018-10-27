//
//  ACHDownToUpData.h
//  ACHestia
//
//  Created by Acery on 2018/10/25.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACHDownToUpDataView : UIView


/**动画的进度*/
@property (assign, nonatomic) CGFloat progress;

/**是否能进行动画*/
@property (assign, nonatomic) BOOL canAnimate;

/**
 * 开始动画，在这个方法中，创建了内部的动画驱动，并且把canAnimate设置为YES。
 */
-(void)startAnimate;

/**
 * 这个方法清除了内部的动画驱动，并且把canAnimate设置为NO。
 */
-(void)endAnimate;


/**
 * 这个方法清除了内部的动画驱动，并且把canAnimate设置为NO的同时清空还原原来的动画
 */
-(void)cancelAnimate;


/**
 * 快速创建ACHDownToUpDataView的方法，传入了一个描述背景的视图（图片和位置）
 * 这个视图其实是不在ACHDownToUpDataView上显示的
 */

+(instancetype)downToUpDataViewWithBKImageView:(UIImageView *)bkimageView;


@end

NS_ASSUME_NONNULL_END
