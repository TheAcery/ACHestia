//
//  ACHTableSectionHeaderView.m
//  ACHestia
//
//  Created by Acery on 2018/10/18.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHDelicacyTableSectionHeaderView.h"
#import "ACHButton.h"

@interface ACHDelicacyTableSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet ACHButton *oneButton;
@property (weak, nonatomic) IBOutlet ACHButton *twoButton;
@property (weak, nonatomic) IBOutlet ACHButton *threeButton;

@end

@implementation ACHDelicacyTableSectionHeaderView

+(instancetype)tableSectionHeaderView
{
    return [[NSBundle mainBundle]loadNibNamed:@"ACHDelicacyTableSectionHeaderView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
    [self addScrollViewitems];
}


#pragma mark - funs
/****************************************************************************************************************/

-(void)addScrollViewitems
{
    
}

@end
