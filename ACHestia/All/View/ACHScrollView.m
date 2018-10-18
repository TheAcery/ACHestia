//
//  ACHScrollView.m
//  ACHestia
//
//  Created by Acery on 2018/10/16.
//  Copyright © 2018年 Acery. All rights reserved.
//  无限滚动

#import "ACHScrollView.h"

@interface ACHScrollView ()

@property (nonatomic, weak) UIView *contentViewOne;

@property (nonatomic, weak) UIView *contentViewTwo;

@property (nonatomic, weak) UIView *contentViewThree;

@property (assign, nonatomic) CGFloat lastBoundsX;

@property (assign, nonatomic) NSInteger pageUpCount;

@property (nonatomic, strong) NSArray<UIView *> *views;

@property (assign, nonatomic) NSInteger nowPage;

@property (nonatomic, weak) UIPanGestureRecognizer *pan;

@end

@implementation ACHScrollView


#warning TODO 让scrollView循环滚动

/**
 * 两个view的来回切换，但会导致contentoffsize越来越大，这样会产生什么问题？ -> 在滚动完成之后同时设置view的frame和scroll的contentoffsize.
 * 从scrll的bounds入手？-> conyentoffsize的原理.
 * 滚动保持原有的逻辑，改变contentvView的frame - page up frame的x加上bounds的偏移量 - page down frame的x减去bounds的偏移量 ------>实现方法
 * 接着每次更新两个contentView的视图 ------>逻辑
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
        [self setUpPanGestureRecognizer];
        
    }
    return self;
}


#pragma mark - setUp
/****************************************************************************************************************/


/**添加手势*/
-(void)setUpPanGestureRecognizer
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    self.pan = pan;
    [self addGestureRecognizer:pan];
}

/**添加ContentViews*/
-(void)setUpContentViews:(CGRect)frame
{
    UIView *contentViewOne = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    contentViewOne.backgroundColor = UIColor.redColor;
    self.contentViewOne = contentViewOne;
    
    UIView *contentViewTwo = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    contentViewTwo.backgroundColor = UIColor.blackColor;
    self.contentViewTwo = contentViewTwo;
    
    UIView *contentViewThree = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    contentViewThree.backgroundColor = UIColor.yellowColor;
    self.contentViewThree = contentViewThree;
    
    [self addSubview:contentViewOne];
    [self addSubview:contentViewTwo];
    [self addSubview:contentViewThree];
}

/**初始化ACHScrollView*/
-(void)setUpACHScrollView
{
    self.clipsToBounds = YES;
    self.pageUpCount = 0;
    self.nowPage = 0;
}

#pragma mark - funs
/****************************************************************************************************************/

-(void)pageUp
{
    self.pageUpCount++;
    
}

-(void)addViewToContentView:(CGPoint)contentOffset
{
    //首先添加两个view
    //在pageUp调用的时候加载下一个view --- 根据什么来创建下一个view？当前的滚动的位置 / self.ACwidth % views.count
    //获取scrollView滚动的位置 - 通过代理方法回调 - (void)scrollViewDidScroll:(UIScrollView *)scrollView;  传入contentOffset判断是否s需要加入新的view
    
   
    NSInteger page = contentOffset.x / self.ACwidth;
    
    NSInteger viewIndex = page % self.views.count;
    if (page != self.nowPage)
    {
        if (page < self.nowPage)
        {
            //lastView
            [self nextView];
            NSLog(@"page -- %zd",viewIndex);
        }
        if (page > self.nowPage)
        {
            //nextView
            [self lastView];
            NSLog(@"page -- %zd",viewIndex);
        }
    }
   
    
    self.nowPage = page;

}

-(void)nextView
{
    //设置frame 添加view
    
}

-(void)lastView
{
    
}


#pragma mark - layerOut
/****************************************************************************************************************/

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGFloat boundsX = self.bounds.origin.x;
    
    self.contentViewOne.ACx =  -self.bounds.size.width * 1;
    self.contentViewTwo.ACx = 0;
    self.contentViewThree.ACx = self.bounds.size.width * 1;

    //计算下一个contentView该呈现那个view
//    NSLog(@"bounds ---- %f",boundsX);
    
//    self.pageUpCount
    
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
