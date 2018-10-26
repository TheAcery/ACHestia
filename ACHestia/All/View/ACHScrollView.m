//
//  ACHScrollView.m
//  ACHestia
//
//  Created by Acery on 2018/10/16.
//  Copyright © 2018年 Acery. All rights reserved.
//  无限滚动

#import "ACHScrollView.h"

#define MaxCount (self.views.count + 2)

@interface ACHScrollView ()

@property (nonatomic, strong) NSTimer *scrollViewAutoScrollTimer;

@end

@implementation ACHScrollView



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
 * 如何让subView滚动，保持原来的方式？继承scrollView的滚动和分页，在滚动结束判断发牌器的位置，但是scrollView改变的是bounds，我们希望改变的是子视图的frame
 */

/**
 * 在开始滚动的时候判断，是pageUP还是pageDown ——————> panGestureRecognizer
 * 向前滚动的时候把contentViewPresent的frame的x赋值成contentViewDispaly的x加上self的宽度，向后的时候减去self的宽度。他们在刚开始的时候都在0，0
 * 在滚动结束的时候交换指针，怎么判断结束滚动，在contentViewDispaly滚出屏幕的时候就该调整contentViewDispaly的位置
 */

#pragma mark - lazy init
/****************************************************************************************************************/




#pragma mark - init funs
/****************************************************************************************************************/

+(instancetype)scrollViewWithFrame:(CGRect)frame Views:(nonnull NSArray<UIView *> *)views
{
    ACHScrollView *scrollView = [[ACHScrollView alloc]initWithFrame:frame Views:views];
    
    return scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame Views:(NSArray<UIView *> *)views
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.views = views;
        [self setUpACHScrollView];
        [self addSubViews];
    }
    return self;
}


#pragma mark - setUp
/****************************************************************************************************************/

/**初始化ACHScrollView*/
-(void)setUpACHScrollView
{
    self.clipsToBounds = YES;
    self.contentOffset = CGPointMake(self.ACwidth, 0);
    self.decelerationRate = 1;
    self.pagingEnabled = YES;
    self.bounces = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
}

#pragma mark - funs
/****************************************************************************************************************/


/**添加所有的子控件*/
-(void)addSubViews
{
    
    for (int count = 0; count < MaxCount; count++)
    {
        UIView *subView = [[UIView alloc]init];
        
        //添加所有的subViews
        if (count == 0)
        {
            //第一个应该显示最后一个视图
            subView = [subView copyFromView:self.views.lastObject];
            subView.frame = CGRectMake(0, 0, self.ACwidth, self.ACheight);
            [self addSubview:subView];
            
            continue;
        }
        
        if (count == MaxCount - 1)
        {
            //最后一张应该显示最后第一个视图
            subView = [subView copyFromView:self.views.firstObject];
            subView.frame = CGRectMake((MaxCount - 1) * self.ACwidth, 0, self.ACwidth, self.ACheight);
            [self addSubview:subView];
            
            continue;
        }
        //添加其余的图片
        subView = self.views[count -1];
        subView.frame = CGRectMake(count * self.ACwidth, 0, self.ACwidth, self.ACheight);
        [self addSubview:subView];
    }
    
    self.contentSize = CGSizeMake(self.ACwidth * MaxCount, 0);
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
   
    if (self.contentOffset.x == 0)
    {
        self.contentOffset = CGPointMake(self.views.count * self.ACwidth, 0);
    }
    
    if (self.contentOffset.x == (self.views.count + 1) * self.ACwidth)
    {
        self.contentOffset = CGPointMake(self.ACwidth, 0);
    }

}

-(void)pageIsUp:(BOOL)up
{

   __block BOOL animtateFinish = YES;
    
    if (animtateFinish && self.window)//
    {
        [UIView animateWithDuration:0.3 animations:^{
            animtateFinish = NO;
            self.contentOffset = up ? CGPointMake(self.contentOffset.x + self.ACwidth, 0) : CGPointMake(self.contentOffset.x - self.ACwidth, 0);
        } completion:^(BOOL finished) {
            animtateFinish = YES;
            if ([self.loopScrollDelegate respondsToSelector:@selector(didACHScrollView:ScrollAtViewWithIndex:)])
            {
                [self.loopScrollDelegate didACHScrollView:self ScrollAtViewWithIndex:self.contentOffset.x / self.ACwidth];
            }
        }];
    }
    
}



#pragma mark - setting funs
/****************************************************************************************************************/

- (void)setViews:(NSArray<UIView *> *)views
{
    _views = views;
    [self addSubViews];
}


@end
