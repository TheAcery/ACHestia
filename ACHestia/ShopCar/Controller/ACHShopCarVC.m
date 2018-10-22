//
//  ACHShopCarVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/21.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHShopCarVC.h"

//view

#import "ACHScrollView.h"

@interface ACHShopCarVC ()

@property (nonatomic, weak) ACHScrollView *scrollView;

@end

@implementation ACHShopCarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    ACHScrollView *scrollView =
    ({
        NSMutableArray *views = [NSMutableArray array];
        
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
        view1.backgroundColor = UIColor.redColor;
        [views addObject:view1];
        
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
        view2.backgroundColor = UIColor.blueColor;
        [views addObject:view2];
        
        UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
        view3.backgroundColor = UIColor.blackColor;
        [views addObject:view3];
        ACHScrollView *scrollView = [ACHScrollView scrollViewWithFrame:CGRectMake(0, 200, 375, 200) Views:views];
        self.scrollView = scrollView;
        scrollView;
    });
    
    
    [self.view addSubview:scrollView];
    
    UIButton *pageUp =
    ({
        
        UIButton *pageUp = [UIButton buttonWithType:UIButtonTypeCustom];
        pageUp.frame = CGRectMake(0, 500, 50, 50);
        pageUp.backgroundColor = UIColor.redColor;
        [pageUp addTarget:self action:@selector(pageUp) forControlEvents:UIControlEventTouchUpInside];
        pageUp;
    });
    
    UIButton *pageDown =
    ({
        
        UIButton *pageDown = [UIButton buttonWithType:UIButtonTypeCustom];
        pageDown.frame = CGRectMake(100, 500, 50, 50);
        pageDown.backgroundColor = UIColor.blueColor;
        [pageDown addTarget:self action:@selector(pageDown) forControlEvents:UIControlEventTouchUpInside];
        pageDown;
    });
    
    [self.view addSubview:pageUp];
    [self.view addSubview:pageDown];
    
    
}


#pragma mark - action
/****************************************************************************************************************/

-(void)pageUp
{
    [self.scrollView pageUp];
}

-(void)pageDown
{
    [self.scrollView pageDown];
}


@end
