//
//  ACHFastViewSmallView.m
//  ACHestia
//
//  Created by Acery on 2018/10/23.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHFastViewSmallScrollView.h"
#import "ACHScrollView.h"
#import "ACHButton.h"

#warning TODO 实现逻辑，自动滚动，index的缩放和联动

@interface ACHFastViewSmallScrollView () <UIScrollViewDelegate>

@property (nonatomic, weak) ACHScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentview;

#pragma mark - buttons
/****************************************************************************************************************/

@property (weak, nonatomic) IBOutlet ACHButton *buttonnOne;
@property (weak, nonatomic) IBOutlet ACHButton *buttonTwo;
@property (weak, nonatomic) IBOutlet ACHButton *buttonThree;
@property (weak, nonatomic) IBOutlet ACHButton *buttonFour;
@property (weak, nonatomic) IBOutlet ACHButton *buttonFive;


@end

@implementation ACHFastViewSmallScrollView



+(instancetype)fastViewSmallScrollViewWithViews:(NSArray<ACHFastViewSmallScrollViewCell *> *)views;
{
   return [[ACHFastViewSmallScrollView alloc]initWithViews:views];
}

- (instancetype)initWithViews:(NSArray<ACHFastViewSmallScrollViewCell *> *)views;
{
    self.views = views;
    return [self initWithFrame:self.frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[NSBundle mainBundle]loadNibNamed:@"ACHFastViewSmallScrollView" owner:nil options:nil].firstObject;
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.ACwidth = SCRENNBOUNDS.size.width;
    
}

#pragma mark - setting funs
/****************************************************************************************************************/

- (void)setViews:(NSArray<ACHFastViewSmallScrollViewCell *> *)views
{
     _views = views;
    if (self.scrollView) return;
    //添加所有的子视图
    ACHScrollView *scrollView = [ACHScrollView scrollViewWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, self.scrollContentview.ACheight) Views:self.views];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    
    [self.scrollContentview addSubview:scrollView];
    
    //开启自动滚动
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [scrollView scrollViewAutoScroll:3.0];
//    });

   
}


#pragma mark - UIScrollViewDelegate
/****************************************************************************************************************/

- (void)scrollViewWillBeginDragging:(ACHScrollView *)scrollView;
{
    //在开始拖拽的时候结束滚动
    [scrollView scrollViewCancelAutoScroll];
    
    NSLog(@"end");
}

- (void)scrollViewDidEndDecelerating:(ACHScrollView *)scrollView;
{
    if (!scrollView.dragging)
    {
        //在结束拖拽同时停止滚动个的时候结束滚动
        [scrollView scrollViewAutoScroll:3.0];
        
        NSLog(@"start");
    }
}

@end
