//
//  ACHBrandVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/24.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHBrandVC.h"

@interface ACHBrandVC ()

@end

@implementation ACHBrandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.barTitle = @"品牌";
    
    self.view.backgroundColor = UIColor.blueColor;
}

#pragma mark - init funs
/****************************************************************************************************************/
+(instancetype)brandVCWithTitle:(NSString *)title;
{
    ACHBrandVC *vc = [[ACHBrandVC alloc]init];
    vc.barTitle = title;
    return vc;
}

@end
