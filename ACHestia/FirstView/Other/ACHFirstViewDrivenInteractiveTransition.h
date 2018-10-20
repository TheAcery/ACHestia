//
//  ACHFirstViewDrivenInteractiveTransition.h
//  ACHestia
//
//  Created by Acery on 2018/10/19.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACHFirstViewDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition

-(instancetype)initWithGestureRecognizer:(UIGestureRecognizer *)gr;

@end

NS_ASSUME_NONNULL_END
