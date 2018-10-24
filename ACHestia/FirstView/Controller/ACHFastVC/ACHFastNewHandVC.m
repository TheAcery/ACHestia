//
//  ACHFastNewHandVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/23.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHFastNewHandVC.h"

@interface ACHFastNewHandVC ()

@end

@implementation ACHFastNewHandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.barTitle = @"新手";
    
    self.view.backgroundColor = UIColor.redColor;
}

#pragma mark - init funs
/****************************************************************************************************************/
+(instancetype)fastNewHandVCWithTitle:(NSString *)title
{
    ACHFastNewHandVC *vc = [[ACHFastNewHandVC alloc]init];
    vc.barTitle = title;
    return vc;
}


@end
