//
//  ACHFirstViewTranslationAnimtor.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//  使用自定义的转场动画取消navcpop时导航栏仍显示的问题 ,描述所有的跳转动画
//  在移动控制器的视图的同时为控制器视图的导航栏添加随控制器视图平移的动画

#import "ACHFirstViewTranslationAnimtor.h"


@interface ACHFirstViewTranslationAnimtor ()


@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, weak) UIView *toView;

@property (nonatomic, weak) UIViewController *toVC;

@property (nonatomic, weak) UIView *fromView;

@property (nonatomic, weak) UIViewController *fromVC;

@end

@implementation ACHFirstViewTranslationAnimtor

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    /**实现动画*/
    
    [self getVCsAndViews:transitionContext];
    
    //判断是否是pop
    NSInteger toVCIndex = [self.toVC.navigationController.childViewControllers indexOfObject:self.toVC];
    NSInteger fromVCIndex = [self.fromVC.navigationController.childViewControllers indexOfObject:self.fromVC];
    
    if (fromVCIndex > toVCIndex)
    {
       
        [self prepareAnimtorForPOP];
    }
    else
    {
        [self prepareAnimtorForPUSH];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (fromVCIndex > toVCIndex)
        {
            
            [self animtorForPOP];
            
        }
        else
        {

            
            [self animtorForPUSH];
        }
        
    } completion:^(BOOL finished) {
        
        self.fromVC.navigationController.navigationBar.transform = CGAffineTransformIdentity;
        self.toVC.navigationController.navigationBar.transform = CGAffineTransformIdentity;
        self.toView.transform = CGAffineTransformIdentity;
        self.fromView.transform = CGAffineTransformIdentity;
        
        BOOL isfinish = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isfinish];
        
    }];
}

#pragma mark - funs
/****************************************************************************************************************/


-(void)getVCsAndViews:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.containerView = transitionContext.containerView;
    
    //get toVC
    self.toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.toView = self.toVC.view;
    
    //get fromVC
    self.fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.fromView = self.fromVC.view;
}

-(void)animtorForPOP
{
    self.toView.transform = CGAffineTransformTranslate(self.toView.transform,SCRENNBOUNDS.size.width, 0);
    self.fromVC.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(SCRENNBOUNDS.size.width, 0);
}


-(void)animtorForPUSH
{
    self.toView.transform = CGAffineTransformTranslate(self.toView.transform,-SCRENNBOUNDS.size.width,0);
    self.fromView.transform = CGAffineTransformTranslate(self.fromView.transform,-SCRENNBOUNDS.size.width,0);
    self.toVC.navigationController.navigationBar.transform = CGAffineTransformIdentity;
}


-(void)prepareAnimtorForPOP
{
    [self.containerView addSubview:self.fromView];
    [self.containerView addSubview:self.toView];
    self.toView.transform = CGAffineTransformTranslate(self.toView.transform,-SCRENNBOUNDS.size.width,- 64);
}

-(void)prepareAnimtorForPUSH
{
    [self.containerView addSubview:self.fromView];
    [self.containerView addSubview:self.toView];
    self.toView.transform = CGAffineTransformTranslate(self.toView.transform,SCRENNBOUNDS.size.width,0);
    self.toVC.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(SCRENNBOUNDS.size.width, 0);
}

@end
