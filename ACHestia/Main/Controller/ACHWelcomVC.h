//
//  ACHWelcomVC.h
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACHWelcomVC : UIViewController

+(instancetype)welcomeVC;

/**设置欢迎界面显示的图片*/
-(void)setImageViewImage:(UIImage *)image;


@end

NS_ASSUME_NONNULL_END
