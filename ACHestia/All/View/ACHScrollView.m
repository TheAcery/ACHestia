//
//  ACHScrollView.m
//  ACHestia
//
//  Created by Acery on 2018/10/16.
//  Copyright © 2018年 Acery. All rights reserved.
//  无限滚动

#import "ACHScrollView.h"

@interface ACHScrollView ()

@property (nonatomic, weak) UIView *contentViewDispaly;

@property (nonatomic, weak) UIView *contentViewPresent;

@property (nonatomic, weak) UIView *contentViewTemp;

@property (assign, nonatomic) NSInteger pageNow;

@property (nonatomic, strong) NSArray<UIView *> *views;

@property (nonatomic, weak) UIPanGestureRecognizer *pan;

@end

@implementation ACHScrollView

#warning TODO 实现无限滚动,添加手势


/**
 * 两个view的来回切换，但会导致contentoffsize越来越大，这样会产生什么问题？ -> 在滚动完成之后同时设置view的frame和scroll的contentoffsize.
 * 从scrll的bounds入手？-> conyentoffsize的原理.
 * 滚动保持原有的逻辑，改变contentvView的frame - page up frame的x加上bounds的偏移量 - page down frame的x减去bounds的偏移量 ------>实现方法
 * 接着每次更新两个contentView的视图 ------>逻辑
 */

/**
* 在最开始的时候第一个subView在最后面，需要在最开始的时候就能向后滚动
* 在每次显示的一个subView的时候我们需要判断他的index，然后加载它前后的视图 ————> views，然后重新设置滚动区域
* 并不是每次都需要加载前后的视图，up的时候加载前视图，down的时候加载后视图，————> 判断up down？
* 如何让subView滚动，保持原来的方式？
*/

#pragma mark - lazy init
/****************************************************************************************************************/




#pragma mark - init funs
/****************************************************************************************************************/

+(instancetype)scrollViewWithFrame:(CGRect)frame Views:(NSArray <UIView *>*)views;
{
    ACHScrollView *scrollView = [[ACHScrollView alloc]initWithFrame:frame Views:views];
    
    return scrollView;
}


- (instancetype)initWithFrame:(CGRect)frame Views:(NSArray <UIView *>*)views
{
    self = [self initWithFrame:frame];
    if (self)
    {
        self.views = views;
        
        [self addViewToContentView:CGPointZero];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUpACHScrollView];
        [self setUpContentViews:frame];
//        [self setUpPanGestureRecognizer];
        
    }
    return self;
}


#pragma mark - setUp
/****************************************************************************************************************/


///**添加手势*/
//-(void)setUpPanGestureRecognizer
//{
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
//    self.pan = pan;
//    [self addGestureRecognizer:pan];
//}

/**添加ContentViews*/
-(void)setUpContentViews:(CGRect)frame
{
    UIView *contentViewDispaly = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    contentViewDispaly.backgroundColor = UIColor.redColor;
    [contentViewDispaly addSubview:self.views[0]];
    self.pageNow = 0;
    self.contentViewDispaly = contentViewDispaly;
    
    UIView *contentViewPresent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    contentViewPresent.backgroundColor = UIColor.blackColor;
    self.contentViewPresent = contentViewPresent;
    
    [self addSubview:contentViewDispaly];
    [self addSubview:contentViewPresent];
}

/**初始化ACHScrollView*/
-(void)setUpACHScrollView
{
    self.clipsToBounds = YES;

}

#pragma mark - funs
/****************************************************************************************************************/

-(void)pageUp
{
    [self pageIsUp:YES];
}

-(void)pageDown
{
   [self pageIsUp:NO];
}

-(void)addViewToContentView:(CGPoint)contentOffset
{
    
}


-(void)pageIsUp:(BOOL)up
{
    static BOOL animateFinished = YES;
    
    if (!animateFinished) return;
#warning TODO 动画延迟，每次点击的间隔超过0.3s就会出现,让动画执行完毕再接受下一次的点击，这个问题是滚动机制带来的，在动画开始的时候有可能contentViewPresent的x改变了好几次
    //计算当前显示的页数
    [self pageNowIsUp:up];
    //设置发牌器的当前视图
    [self.contentViewPresent addSubview:self.views[self.pageNow]];
    //发牌器在前面
    animateFinished = NO;
    self.contentViewPresent.ACx = up ? self.ACwidth : - self.ACwidth;
    //向后滚动
    [UIView animateWithDuration:0.3 animations:^{
        //发牌器滚动
        self.contentViewPresent.ACx = 0;
        //显示视图滚动
        self.contentViewDispaly.ACx = up ? - self.ACwidth : self.ACwidth;
        
    } completion:^(BOOL finished){
        
        //交换指针，让dispaly始终在原点
        self.contentViewTemp = self.contentViewDispaly;
        self.contentViewDispaly = self.contentViewPresent;
        self.contentViewPresent = self.contentViewTemp;
        
        NSLog(@"rect ----- %@",NSStringFromCGRect(self.contentViewDispaly.frame));
        animateFinished = YES;
    }];
}

-(void)pageNowIsUp:(BOOL)up
{
    
    if (up)
    {
        
        if (self.pageNow == self.views.count - 1)
        {
            self.pageNow = 0;
        }
        else
        {
            self.pageNow++;
        }
    }
    else
    {
        if (self.pageNow == 0)
        {
            self.pageNow = self.views.count - 1;
        }
        else
        {
            self.pageNow--;
        }
        
    }
    
    NSLog(@"page --- %zd",self.pageNow);
}


#pragma mark - layerOut
/****************************************************************************************************************/

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.contentViewPresent.ACx = - self.ACwidth;


    
}

#pragma mark - action
/****************************************************************************************************************/

-(void)pan:(UIPanGestureRecognizer* )gr
{
    CGPoint point = [gr translationInView:gr.view];
    
    
    
//    if (-point.x > self.ACwidth * 0.5)
//    {
//        NSLog(@"page up");
//        self.pan.state = UIGestureRecognizerStateEnded;
//    }
    CGFloat Y = self.ACwidth * point.x / (self.ACwidth * 0.5);
    
    NSLog(@"point ----- %@ ---- y ----- %f",NSStringFromCGPoint(point),Y);
    
    CGRect bounds = CGRectMake(Y, 0, self.ACwidth, self.ACheight);
    
    self.bounds = bounds;
}


@end
