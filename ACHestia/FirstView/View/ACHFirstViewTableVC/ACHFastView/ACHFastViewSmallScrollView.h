//
//  ACHFastViewSmallView.h
//  ACHestia
//
//  Created by Acery on 2018/10/23.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACHFastViewSmallScrollViewCell.h"


NS_ASSUME_NONNULL_BEGIN

@interface ACHFastViewSmallScrollView : UIView

+(instancetype)fastViewSmallScrollViewWithViews:(NSArray<ACHFastViewSmallScrollViewCell *> *)views;

@property (nonatomic, strong) NSArray <ACHFastViewSmallScrollViewCell *>* views;

@end

NS_ASSUME_NONNULL_END
