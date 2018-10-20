//
//  ACHFirstViewDrivenInteractiveTransition.m
//  ACHestia
//
//  Created by Acery on 2018/10/19.
//  Copyright © 2018年 Acery. All rights reserved.
//  自定义转场交互

#import "ACHFirstViewDrivenInteractiveTransition.h"

@interface ACHFirstViewDrivenInteractiveTransition ()

@property (nonatomic, weak) UIGestureRecognizer *gr;

@end

@implementation ACHFirstViewDrivenInteractiveTransition

-(instancetype)initWithGestureRecognizer:(UIGestureRecognizer *)gr
{
    if (self = [super init])
    {
        [gr addTarget:self action:@selector(pan:)];
        
        self.gr = gr;
    }
    
    return self;
}


#pragma mark - action
/****************************************************************************************************************/

-(void)pan:(UIScreenEdgePanGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan)
    {
        //手势开始
        
    }
    //计算进度
    CGFloat progress = [gr locationInView:gr.view].x / SCRENNBOUNDS.size.width;
    NSLog(@"  pro %f ----- ",  1 + progress);
    
    [self updateInteractiveTransition:1 + progress];
    
    if (gr.state == UIGestureRecognizerStateEnded)
    {
        //手势结束
        //判断是否需要跳转
        if (progress > 0.3)
        {
            [self finishInteractiveTransition];
        }
        else
        {
             [self cancelInteractiveTransition];
        }
        
       
    }
}

#pragma mark - rewrite funs
/****************************************************************************************************************/


@end
