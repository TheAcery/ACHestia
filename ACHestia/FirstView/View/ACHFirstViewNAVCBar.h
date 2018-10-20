//
//  ACHFirstViewNAVCBar.h
//  ACHestia
//
//  Created by Acery on 2018/10/20.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACHFirstViewNAVCBar : UINavigationBar

+(instancetype)FirstViewNAVCBarWithTitle:(NSString *)title;

#pragma mark - items
/****************************************************************************************************************/

@property (nonatomic, weak) UIBarButtonItem *leftItem;
@property (nonatomic, weak) NSArray <UIBarButtonItem *> *leftItems;

@property (nonatomic, weak) UIBarButtonItem *rightItem;
@property (nonatomic, weak) NSArray <UIBarButtonItem *> *rightItems;

@end

NS_ASSUME_NONNULL_END
