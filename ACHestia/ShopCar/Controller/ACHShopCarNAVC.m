//
//  ACHShopCarVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHShopCarNAVC.h"


//VC
#import "ACHShopCarVC.h"

@interface ACHShopCarNAVC ()

@end

@implementation ACHShopCarNAVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ACHShopCarVC *vc = [[ACHShopCarVC alloc]init];
   
    [self pushViewController:vc animated:YES];
    
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setUpNAVCWithTitle:@"购物车" ImageName:@"icon_shopcart_normal" SelectedImage:@"icon_shopcart_selected"];
    }
    return self;
}

@end
