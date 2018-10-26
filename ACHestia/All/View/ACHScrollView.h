//
//  ACHScrollView.h
//  ACHestia
//
//  Created by Acery on 2018/10/16.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACHScrollView;

NS_ASSUME_NONNULL_BEGIN
@protocol ACHScrollViewLoopScroDelegate <NSObject>

-(void)didACHScrollView:(ACHScrollView *)ACHScrollView ScrollAtViewWithIndex:(NSInteger)index;

@end


@interface ACHScrollView : UIScrollView

+(instancetype)scrollViewWithFrame:(CGRect)frame Views:(NSArray<UIView *> *)views;

@property (nonatomic, weak) id <ACHScrollViewLoopScroDelegate> loopScrollDelegate;

-(void)pageIsUp:(BOOL)up;

@property (nonatomic, strong) NSArray<UIView *> *views;

@end

NS_ASSUME_NONNULL_END
