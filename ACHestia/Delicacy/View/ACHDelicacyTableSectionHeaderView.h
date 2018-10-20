//
//  ACHTableSectionHeaderView.h
//  ACHestia
//
//  Created by Acery on 2018/10/18.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ACHButton;


typedef NS_ENUM(NSInteger, ACHDelicacyTableSectionHeaderViewSubViewState)
{
    ACHDelicacyTableSectionHeaderViewSubViewStateOne,
    ACHDelicacyTableSectionHeaderViewSubViewStateTwo,
    ACHDelicacyTableSectionHeaderViewSubViewStateThree
};

@protocol ACHDelicacyTableSectionHeaderViewDelegate <NSObject>

@optional

-(void)didDelicacyTableSectionHeaderViewOneButtonClip:(ACHButton *)btn;

-(void)didDelicacyTableSectionHeaderViewTwoButtonClip:(ACHButton *)btn;

-(void)didDelicacyTableSectionHeaderViewThreeButtonClip:(ACHButton *)btn;

@end

@interface ACHDelicacyTableSectionHeaderView : UIView


+(instancetype)tableSectionHeaderView;


-(void)scrollToOne;

-(void)scrollToTwo;

-(void)scrollToThree;

@property (nonatomic, weak) id <ACHDelicacyTableSectionHeaderViewDelegate> delegate;

@property (assign, nonatomic,readonly) ACHDelicacyTableSectionHeaderViewSubViewState subViewState;

@end

NS_ASSUME_NONNULL_END
