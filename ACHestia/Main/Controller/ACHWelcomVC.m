//
//  ACHWelcomVC.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//  欢迎的计时界面,可以跳过

#import "ACHWelcomVC.h"

#import "ACHTabBarController.h"


@interface ACHWelcomVC ()

@property (weak, nonatomic) IBOutlet UIButton *jumpToWedButton;

@property (weak, nonatomic) IBOutlet UIButton *jumpButton;

@property (nonatomic, weak) NSTimer *timer;

@property (assign, nonatomic) NSInteger timeCountDown;

@end

@implementation ACHWelcomVC

#pragma mark - init funs
/****************************************************************************************************************/


+(instancetype)welcomeVC
{
    UIStoryboard *stotyBoard = [UIStoryboard storyboardWithName:@"ACHWelcomVC" bundle:nil];
    return [stotyBoard instantiateInitialViewController];
}

#pragma mark - viewLoad funs
/****************************************************************************************************************/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self intoMainInterface];
    
    //init view
    
    [self.jumpButton addTarget:self action:@selector(jumpButtonClip:) forControlEvents:UIControlEventTouchUpInside];
    [self.jumpToWedButton addTarget:self action:@selector(jumpToWebButtonClip:) forControlEvents:UIControlEventTouchUpInside];
    
    //add timer
    self.timeCountDown = 3;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        self.timeCountDown--;
        //倒计时，更改jumpButton的标题
        [self.jumpButton setTitle:[NSString stringWithFormat:@"跳过%zd",self.timeCountDown] forState:UIControlStateNormal];
        //当倒计时为0的时候结束
        if (self.timeCountDown == 0)
        {
            [timer invalidate];
            //进入主界面
            [self intoMainInterface];
        }
        
    }];
    
    self.timer = timer;
    
    NSRunLoop *runloop = [NSRunLoop mainRunLoop];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - action
/****************************************************************************************************************/

-(void)jumpButtonClip:(UIButton *)btn
{
    [self intoMainInterface];
    [self.timer invalidate];
}

-(void)jumpToWebButtonClip:(UIButton *)btn
{
    
}

#pragma mark - funs
/****************************************************************************************************************/


-(void)setImageViewImage:(UIImage *)image
{
    //图片应该从网络获取的，还添加了跳转的功能
    [self.jumpToWedButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.timer invalidate];
}

-(void)intoMainInterface
{
    UIApplication *app = [UIApplication sharedApplication];
    ACHTabBarController *vc = [ACHTabBarController tabBarController];
    app.keyWindow.rootViewController = vc;
}
@end
