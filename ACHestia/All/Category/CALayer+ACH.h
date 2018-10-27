//
//  CALayer+ACH.h
//  ACHestia
//
//  Created by Acery on 2018/10/27.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (ACH)

/**根据遮罩图片名称创建遮罩图层，让其他图层运用它以启用遮罩*/
+(instancetype)layerWithMaskImageName:(NSString *)imageName Frame:(CGRect)frame;

/**根据遮罩图片创建遮罩图层，让其他图层运用它以启用遮罩*/
+(instancetype)layerWithMaskImage:(UIImage *)image Frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
