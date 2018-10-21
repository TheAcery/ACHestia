//
//  ACHTableSectionHeaderView.h
//  ACHestia
//
//  Created by Acery on 2018/10/18.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACHButton.h"

NS_ASSUME_NONNULL_BEGIN



/**
 * 描述了ACHDelicacyTableSectionHeaderViewSubViewState的状态，为了代码的拓展性，可能会改成索引
 */
typedef NS_ENUM(NSInteger, ACHDelicacyTableSectionHeaderTitleIndexViewState)
{
    ACHDelicacyTableSectionHeaderTitleIndexViewInOne,//位于第一位
    ACHDelicacyTableSectionHeaderTitleIndexViewInTwo,//位于第二位
    ACHDelicacyTableSectionHeaderTitleIndexViewInThree//位于第三位
};

@protocol ACHDelicacyTableSectionHeaderViewDelegate <NSObject>

@optional

/**
 * 这一系列的代理方法应该执行tableView的滚动，而且是滚动到指定的位置，也许会把这些方法和并，更改传递titleIndexView的位置机制
 */

/**在滑动到第一组的按钮被点击时调用，传递这个按钮*/
-(void)didDelicacyTableSectionHeaderViewOneButtonClip:(ACHButton *)btn;

/**在滑动到第二组的按钮被点击时调用，传递这个按钮*/
-(void)didDelicacyTableSectionHeaderViewTwoButtonClip:(ACHButton *)btn;

/**在滑动到第三组的按钮被点击时调用，传递这个按钮*/
-(void)didDelicacyTableSectionHeaderViewThreeButtonClip:(ACHButton *)btn;

@end

@interface ACHDelicacyTableSectionHeaderView : UIView


+(instancetype)tableSectionHeaderView;


/**
 * 让titleIndexView滑动到指定的位置，以标示当前位于哪一组，应该抽取方法，直接传入index
 
 * 内部以设置superView的bounds来实现h滚动，并为其添加动画
 */
-(void)scrollToOne;

-(void)scrollToTwo;

-(void)scrollToThree;

@property (nonatomic, weak) id <ACHDelicacyTableSectionHeaderViewDelegate> delegate;

@property (assign, nonatomic,readonly) ACHDelicacyTableSectionHeaderTitleIndexViewState titleIndexViewState;

@end

NS_ASSUME_NONNULL_END
