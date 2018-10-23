//
//  ACHFastView.h
//  ACHestia
//
//  Created by Acery on 2018/10/15.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ACHFastViewJumpView;
@class ACHButton;

@protocol ACHFastViewDelegate <NSObject>

@optional

#pragma mark - JumpView
/****************************************************************************************************************/

/**当FastViewJumpView的FirstButton被点击时调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view FirstButtonClip:(ACHButton *)btn;

/**当FastViewJumpView的FirstButton被点击时调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view CutDownButtonClip:(ACHButton *)btn;


/**当FastViewJumpView的FirstButton被点击时调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view BrandButtonClip:(ACHButton *)btn;

/**当FastViewJumpView的FirstButton被点击时调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view DelicacyButtonClip:(ACHButton *)btn;

@end

@interface ACHFastView : UIView

+(instancetype)fastView;

@property (nonatomic, weak) id <ACHFastViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
