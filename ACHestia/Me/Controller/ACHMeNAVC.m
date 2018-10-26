//
//  ACHMeVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHMeNAVC.h"

#import "ACHMeVC.h"

@interface ACHMeNAVC ()

@end

@implementation ACHMeNAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ACHMeVC *vc = [[ACHMeVC alloc]init];
    
    [self pushViewController:vc animated:YES];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setUpNAVCWithTitle:@"我的" ImageName:@"icon_user_unselect" SelectedImage:@"icon_user_selected"];
    }
    return self;
}

@end
