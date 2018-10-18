//
//  ACHSmallScrollViewCell.m
//  ACHestia
//
//  Created by Acery on 2018/10/15.
//  Copyright © 2018年 Acery. All rights reserved.
//  创建SmallScrollView的每个cell

#import "ACHSmallScrollViewCell.h"

@interface ACHSmallScrollViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;

@end


@implementation ACHSmallScrollViewCell

+(instancetype)smallScrollViewCellWithItem:(ACHSmallScrollViewCellItem *)item;
{
    ACHSmallScrollViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"ACHSmallScrollViewCell" owner:nil options:nil].firstObject;
    
    [cell initWithItem:(item)];
    
    return cell;
}

-(void)initWithItem:(ACHSmallScrollViewCellItem *) item
{
    self.imageView.image = [UIImage imageNamed:item.imageName];
    self.titleLabel.text = item.title;
    self.distanceLabel.text = item.distance;
    self.discountLabel.text = item.discount;
}

@end
