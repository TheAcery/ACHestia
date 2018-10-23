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

@interface ACHShopCarVC () <UIScrollViewDelegate>

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
        
        UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
        view4.backgroundColor = UIColor.orangeColor;
        [views addObject:view4];
        
        UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
        view5.backgroundColor = UIColor.purpleColor;
        [views addObject:view5];
        
        ACHScrollView *scrollView = [ACHScrollView scrollViewWithFrame:CGRectMake(0, 200, 375, 200) Views:views];
        self.scrollView = scrollView;
        scrollView.delegate = self;
        scrollView;
    });
    
    
    [self.view addSubview:scrollView];
    
    UIButton *up = [[UIButton alloc]initWithFrame:CGRectMake(0, 500, 50, 50)];
    [up setTitle:@"up" forState:UIControlStateNormal];
    [up setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [up addTarget:self action:@selector(up) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *down = [[UIButton alloc]initWithFrame:CGRectMake(200, 500, 50, 50)];
    [down setTitle:@"down" forState:UIControlStateNormal];
    [down setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [down addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview:up];
    [self.view addSubview:down];
}


#pragma mark - action
/****************************************************************************************************************/


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    NSInteger index = scrollView.contentOffset.x / scrollView.ACwidth;
    NSLog(@"index --- %zd",index);
}

-(void)up
{

    [self.scrollView pageIsUp:YES];

}

-(void)down
{
    [self.scrollView pageIsUp:NO];
}

@end
