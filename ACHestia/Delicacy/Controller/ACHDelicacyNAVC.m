//
//  ACHDelicacyVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//  有好菜界面的NAVC

#import "ACHDelicacyNAVC.h"
#import "ACHDelicacyTableVC.h"
#import "ACHButton.h"

@interface ACHDelicacyNAVC ()

@end

@implementation ACHDelicacyNAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ACHDelicacyTableVC *vc = [[ACHDelicacyTableVC alloc]init];
    
    [self pushViewController:vc animated:YES];
   
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setUpNAVCWithTitle:@"有好菜" ImageName:@"icon_delicious_food_unselect" SelectedImage:@"icon_delicious_food_selected"];
    }
    return self;
}





@end
