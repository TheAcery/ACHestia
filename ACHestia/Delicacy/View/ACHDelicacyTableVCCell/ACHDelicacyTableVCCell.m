//
//  ACHDelicacyTableVCCell.m
//  ACHestia
//
//  Created by Acery on 2018/10/18.
//  Copyright © 2018年 Acery. All rights reserved.
//  占位视图：占位视图的再次封装

#import "ACHDelicacyTableVCCell.h"

//view

#import "ACHDelicacyTableVCCellShop.h"
#import "ACHDelicacyTableVCCellShopDetail.h"

@interface ACHDelicacyTableVCCell ()

@property (weak, nonatomic) IBOutlet ACHDelicacyTableVCCellShop *shopView;

@property (weak, nonatomic) IBOutlet ACHDelicacyTableVCCellShopDetail *detailView;

@end

@implementation ACHDelicacyTableVCCell

#pragma mark - init funs
/****************************************************************************************************************/

+(instancetype)delicacyTableVCCell
{
    ACHDelicacyTableVCCell *cell = [[NSBundle mainBundle]loadNibNamed:@"ACHDelicacyTableVCCell" owner:nil options:nil].firstObject;
    
    return cell;
}

- (void)awakeFromNib

{
    [super awakeFromNib];
     /**init shopView and detailView*/
    [self setUpViews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - funs
/****************************************************************************************************************/

-(void)setUpViews
{
    /**shopView*/
    ACHDelicacyTableVCCellShop *shopView = [[ACHDelicacyTableVCCellShop alloc]init];
    shopView.frame = self.shopView.bounds;
    
    /**shopView*/
    ACHDelicacyTableVCCellShopDetail *detailView = [[ACHDelicacyTableVCCellShopDetail alloc]init];
    detailView.frame = self.detailView.bounds;
    
    [self.shopView addSubview:shopView];
    [self.detailView addSubview:detailView];
}

@end
