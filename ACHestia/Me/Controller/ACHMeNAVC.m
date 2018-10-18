//
//  ACHMeVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHMeNAVC.h"

@interface ACHMeNAVC ()

@end

@implementation ACHMeNAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
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
