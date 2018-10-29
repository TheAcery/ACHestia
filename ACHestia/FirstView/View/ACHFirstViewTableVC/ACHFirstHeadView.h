//
//  ACHFirstHeadView.h
//  ACHestia
//
//  Created by Acery on 2018/10/17.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACHButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ACHFirstHeadView : UIView


@property (weak, nonatomic) IBOutlet ACHButton *cityButton;
@property (weak, nonatomic) IBOutlet ACHButton *QRCodeButton;

+(instancetype)firstHeadView;

@end

NS_ASSUME_NONNULL_END
