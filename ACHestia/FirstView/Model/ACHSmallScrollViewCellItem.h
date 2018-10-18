//
//  ACHSmallScrollViewCellIteam.h
//  ACHestia
//
//  Created by Acery on 2018/10/15.
//  Copyright © 2018年 Acery. All rights reserved.
//  ACHSmallScrollViewCell的模型，图片使用名字代替，可以改写成请求地址

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACHSmallScrollViewCellItem : NSObject

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *distance;

@property (nonatomic, strong) NSString *discount;

@end

NS_ASSUME_NONNULL_END
