//
//  ACHDelicacyTableVCHeadView.m
//  ACHestia
//
//  Created by Acery on 2018/10/19.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHDelicacyTableVCHeadView.h"

#define SubViewsConut 3

@interface ACHDelicacyTableVCHeadView ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation ACHDelicacyTableVCHeadView

+(instancetype)delicacyTableVCHeadView
{
    return [[NSBundle mainBundle]loadNibNamed:@"ACHDelicacyTableVCHeadView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    for (int subViewsConut = 0; subViewsConut < SubViewsConut; subViewsConut++)
    {
        //add subViews
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(subViewsConut * self.scrollView.ACwidth, 0, self.scrollView.ACwidth, self.scrollView.ACheight)];
        imageView.image = [UIImage imageNamed:@"ORIimage"];
        
        [self.scrollView addSubview:imageView];

    }
    
    self.scrollView.contentSize = CGSizeMake(SubViewsConut * self.scrollView.ACwidth, 0);
}

@end
