//
//  ACHScrollView.h
//  ACHestia
//
//  Created by Acery on 2018/10/16.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACHScrollView : UIView

+(instancetype)scrollViewWithFrame:(CGRect)frame Views:(NSArray <UIView *>*)views;

- (instancetype)initWithFrame:(CGRect)frame Views:(NSArray <UIView *>*)views;

-(void)pageUp;

-(void)addViewToContentView:(CGPoint)contentOffset;

@end

NS_ASSUME_NONNULL_END
