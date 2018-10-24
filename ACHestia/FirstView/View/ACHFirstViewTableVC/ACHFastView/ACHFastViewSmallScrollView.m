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

#define ButtonScaleSize 1.2 //buttons的放大倍数，如果要改这个值，需要重新计算stackView的约束

//因为没有现在没有数据，所以scrollView子视图的点击跳转就先不实现了

@interface ACHFastViewSmallScrollView () <UIScrollViewDelegate,ACHScrollViewLoopScroDelegate>

/**无限滚动到视图*/
@property (nonatomic, weak) ACHScrollView *scrollView;

/**无限滚动到视图的占位视图 from xib*/
@property (weak, nonatomic) IBOutlet UIView *scrollContentview;

/**无限滚动到视图自动滚动定时器*/
@property (nonatomic, strong) NSTimer *scrollViewAutoScrollTimer;

/**buttons的自动布局视图*/
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

/**stackView的宽度约束，他会在设置了buttons重新计算*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewConstraint;

/**scrollView的当前页数*/
@property (assign, nonatomic) NSInteger nowPageCount;

/**所有的buttons，他们对应着scrollView的每个子视图*/
@property (nonatomic, strong) NSMutableArray<ACHButton *> * buttons;

/**上次滚动对应的button，用来恢复缩放*/
@property (nonatomic, weak) ACHButton *lastSelectButton;


#pragma mark - buttons
/****************************************************************************************************************/

/**
 * 如果这些按钮是动态添加的，我们需要知道scrollView的vsubView个数，他们从服务器获得数据，我打算把ACHFastView中所有请求都放在ACHFastView中处理。
 * 所以我们需要依照views来创建所有的按钮，并把它加入xib的Stack View中，他保持了让每个button都登高等宽，所以它会自动缩放。
 * 对于这些button的action可以合并成一个，他们都是在点击的时候让scrollView滚动到指定的page，如果需要跳转到控制器的话，我们需要把事件传递到最近的控制器中来跳转视图。
 */

@end

@implementation ACHFastViewSmallScrollView


#pragma mark - init funs
/****************************************************************************************************************/


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


#pragma mark - lazy init
/****************************************************************************************************************/

- (NSMutableArray<ACHButton *> *)buttons
{
    if (_buttons == nil)
    {
        _buttons = [NSMutableArray array];
    }
    
    return _buttons;
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
    scrollView.loopScrollDelegate = self;
    
    [self addButtons];
    
    [self.scrollContentview addSubview:scrollView];
    
    //开启自动滚动
    [self scrollViewAutoScroll:3.0];
    
    //初始化nowPage和改变按钮大小
    self.nowPageCount = 1;
    [self chageButtonFrame];
   
}

-(void)addButtons
{
    //获取views的个数
    NSInteger viewsCount = self.views.count;
    //循环创建和设置按钮
    
    for (NSInteger count = 0; count < viewsCount; count++)
    {
        ACHButton *button = [[ACHButton alloc]init];
        //设置image
        [button setBackgroundImage:[UIImage imageNamed:@"ORIimage"] forState:UIControlStateNormal];
        //设置target
        [button addTarget:self action:@selector(buttonClip:) forControlEvents:UIControlEventTouchUpInside];
        
        [button sizeToFit];

        //加入到stackView
        
        [self.stackView addArrangedSubview:button];
        
        //添加到buttons
        
        [self.buttons addObject:button];
        
    }
    
    //重新计算stackViewConstraint
    CGFloat constant = (self.stackView.ACheight * viewsCount) + (self.stackView.spacing * (viewsCount - 1));
    
    if (constant >= SCRENNBOUNDS.size.width)
    {
        constant = SCRENNBOUNDS.size.width;
    }
    self.stackViewConstraint.constant = constant;
}

-(void)chageButtonFrame
{
    //复原之前按钮的大小
    
    [UIView animateWithDuration:0.3 animations:^{
        
      self.lastSelectButton.transform = CGAffineTransformIdentity;
        
    }];
    //获取当前选中的按钮
    ACHButton *selectButton = [self.buttons objectAtIndex:self.nowPageCount - 1];
    //改变当前按钮的大小
    [UIView animateWithDuration:0.3 animations:^{
        selectButton.transform = CGAffineTransformScale(selectButton.transform, ButtonScaleSize, ButtonScaleSize);
    }];
    //赋值上一次选中的按钮
    self.lastSelectButton = selectButton;
}


#pragma mark - UIScrollViewDelegate
/****************************************************************************************************************/

- (void)scrollViewWillBeginDragging:(ACHScrollView *)scrollView;
{
    //在开始拖拽的时候结束滚动
    [self scrollViewCancelAutoScroll];
    
}

- (void)scrollViewDidEndDecelerating:(ACHScrollView *)scrollView;
{
    if (!scrollView.dragging)
    {
        //在结束拖拽同时停止滚动个的时候结束滚动
        [self scrollViewAutoScroll:3.0];
        
    }
    
    //判断拖动到页数
    self.nowPageCount = scrollView.contentOffset.x / scrollView.ACwidth;
    
    [self chageButtonFrame];
    
}

-(void)scrollViewAutoScroll:(CGFloat)timerInterval
{
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:timerInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self.scrollView pageIsUp:YES];
    }];
    
    
    
    self.scrollViewAutoScrollTimer = timer;
    
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}


-(void)scrollViewCancelAutoScroll
{
    [self.scrollViewAutoScrollTimer invalidate];
}



#pragma mark - ACHScrollViewLoopScroDelegate
/****************************************************************************************************************/


/**
 * 在这个代理方法中获得ScrollView的index，通过这index来让对应的按钮变大，上一个按钮缩小
 */

-(void)didACHScrollView:(ACHScrollView *)ACHScrollView ScrollAtViewWithIndex:(NSInteger)index
{
    
    self.nowPageCount = index;
    //更改按钮的大小
    [self chageButtonFrame];
}

#pragma mark - action
/****************************************************************************************************************/


/**buttons aciton*/

-(void)buttonClip:(ACHButton *)btn
{
    //取消自动滚动
    [self scrollViewCancelAutoScroll];
    //获取button index
    NSInteger buttonIndex = [self.buttons indexOfObject:btn];
    //跳转到这一页
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.ACwidth * (buttonIndex + 1), 0) animated:YES];
    //更新按钮状态
    self.nowPageCount = buttonIndex + 1;
    [self chageButtonFrame];
    //开启自动滚动
    [self scrollViewAutoScroll:3.0];
}

@end
