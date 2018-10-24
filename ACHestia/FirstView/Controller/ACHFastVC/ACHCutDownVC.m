//
//  ACHCutDownVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/24.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHCutDownVC.h"

@interface ACHCutDownVC ()

@end

@implementation ACHCutDownVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.barTitle = @"砍价";
    
    self.view.backgroundColor = UIColor.yellowColor;
}

#pragma mark - init funs
/****************************************************************************************************************/
+(instancetype)cutDownVCWithTitle:(NSString *)title;
{
    ACHCutDownVC *vc = [[ACHCutDownVC alloc]init];
    vc.barTitle = title;
    return vc;
}

@end
