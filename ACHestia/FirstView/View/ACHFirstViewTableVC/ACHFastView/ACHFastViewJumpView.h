//
//  ACHFastViewJumpView.h
//  ACHestia
//
//  Created by Acery on 2018/10/23.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACHButton.h"

@class ACHFastViewJumpView;

NS_ASSUME_NONNULL_BEGIN

@protocol ACHFastViewJumpViewDelegate <NSObject>

@optional


/**在FirstButton被点击到时候调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view FirstButtonClip:(ACHButton *)btn;

/**在CutDownButton被点击到时候调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view CutDownButtonClip:(ACHButton *)btn;

/**在BrandButton被点击到时候调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view BrandButtonClip:(ACHButton *)btn;

/**在DelicacyButton被点击到时候调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view DelicacyButtonClip:(ACHButton *)btn;

@end

@interface ACHFastViewJumpView : UIView

+(instancetype)fastViewJumpView;

@property (nonatomic, weak) id <ACHFastViewJumpViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
