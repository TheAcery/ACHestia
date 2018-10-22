//
//  ACHACHFirstViewTableViewCell.m
//  ACHestia
//
//  Created by Acery on 2018/10/16.
//  Copyright © 2018年 Acery. All rights reserved.
// ACHFirstViewTableView的cell

#import "ACHFirstViewTableViewCell.h"

@implementation ACHFirstViewTableViewCell

- (void)awakeFromNib
{

    [super awakeFromNib];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - init
/****************************************************************************************************************/

+(instancetype)firstViewTableViewCell
{
    ACHFirstViewTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"ACHFirstViewTableViewCell" owner:nil options:nil].lastObject;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
