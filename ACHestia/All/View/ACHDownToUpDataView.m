//
//  ACHDownToUpData.m
//  ACHestia
//
//  Created by Acery on 2018/10/25.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHDownToUpDataView.h"


#warning TODO 使用mask 来显示遮罩内容,需要这样不透明的logo，其他透明

/**
 * 这部分我们讨论ACHDownToUpData功能的实现
 * 我们拿到的是一张图片，通过裁减图片，我们让图片的头部显示在ACHDownToUpDataView上，并添加在需要下拉刷新的地方，一般是tableView
 * 在tableView我们并不是直接添加到tableView上，而是它的父视图上面，保持在正常的状态下我们看不见它，但是在下拉之后我们能够看见它
 * 在下拉到一定的程度之后开始更新数据，此时tableView保持这个偏移量，并在更新完毕之后回弹tableView，在t下拉没达到一定程度时松手将会回弹
 */

/**
 * 这部分我们来讨论ACHDownToUpData的动画实现
 * 很明显我们需要通过layer的遮罩来实现原来下拉的动画，我们需要让一个layer呈现出上升的波浪动画，同时它的透明度是半透明的。
 * 为了实现波浪动画，我们需要一个形状图层，然后描述波浪的BezierPath,如果需要双波浪的话需要两条贝塞尔曲线
 * 动画的驱动，在view内部驱动动画，我们需要一个定时器来每次让波浪运动，在这个定时器(displayLink)的循环中我们创建新的path，然后让shapeLayer从上次的形状过渡到现在的形状。
 * 所以我们需要不停的创建动画对象,提供一个类属性，不断的修改toValue，然后再动画执行完毕的时候从shapeLayer移除这个动画
 */

@interface ACHDownToUpDataView () <CAAnimationDelegate>

@property (nonatomic, weak) UIImageView *BKImageView;

@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, strong) UIBezierPath *lastPath;

@property (nonatomic, weak) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) CABasicAnimation *animate;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) CADisplayLink *displayLink;



@end

@implementation ACHDownToUpDataView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //初始化视图
        [self setUp];
        //初始化子视图
        [self setUpSubViews];
        //初始化manimate
        [self setUpAnimate];
        //初始化layer
        [self setUpLayer];
  
    }
    return self;
}


#pragma mark - lazy init
/****************************************************************************************************************/

- (CABasicAnimation *)animate
{
    if (_animate == nil)
    {
        _animate = [CABasicAnimation animation];
        _animate.keyPath = @"path";
        _animate.removedOnCompletion = NO;
        _animate.fillMode = kCAFillModeForwards;
        
        _animate.delegate = self;
        
        _animate.duration = 0.3;
        _animate.repeatCount = 1;
    }
    
    return _animate;
}


#pragma mark - funs
/****************************************************************************************************************/

/**
 * 快速创建一个path，每个变量的取值都是从[0 - 1]，为了配合进度计算，在内部会根据frame展开计算最终的值。
 * 和进度有关的只有波浪的整体高度，波浪的水平摆动和垂直摆动都是随机的数值，再前一起基础上，所以只需要传入进度就行
 */

-(void)makePath
{
    //总体高度，浪花的起始位置，结束位置可以用这个数值，为了真实也许会通过这个值计算得到结束的位置，加或减去一个随机值
    CGFloat heightStart = self.ACheight - (self.progress * self.ACheight);
    //浪花的结束高度
    CGFloat heightEnd = heightStart;
    
    /**
     * 通过两个贝塞尔曲线控制点的位置来控制浪花的起伏和水平位移
     * 第一个点的位移区间应该在width的左半边，第二个应该在右半边
     * 第一个点的高度区间应该在总体高度的固定幅度区间中取值，第二个也是，但是要保证他们不一致
     */
    
    CGFloat controlPointOneX = (arc4random() % (NSInteger)(self.ACwidth * 0.25)) + self.ACwidth * 0.25*0.5;
    CGFloat controlPointTwoX = (arc4random() % (NSInteger)(self.ACwidth * 0.25)) + (self.ACwidth * 0.25*0.5) + (self.ACwidth * 0.5) ;
    
    CGFloat controlPointOneY = heightStart + (arc4random() % (NSInteger)self.ACheight * 0.4) - self.ACheight * 0.2;//初始值
    CGFloat controlPointTwoY = heightStart + (arc4random() % (NSInteger)self.ACheight * 0.4) - self.ACheight * 0.2;//初始值
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, heightStart)];
    [path addCurveToPoint:CGPointMake(self.ACwidth, heightEnd) controlPoint1:CGPointMake(controlPointOneX, controlPointOneY) controlPoint2:CGPointMake(controlPointTwoX, controlPointTwoY)];
    
    [path addLineToPoint:CGPointMake(self.ACwidth, self.ACheight)];
    [path addLineToPoint:CGPointMake(0, self.ACheight)];
    
    self.path = path;
}


-(void)startAnimate
{
    self.canAnimate = YES;
    
    
    if (self.displayLink == nil)
    {
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        self.displayLink = displayLink;
    }
    
    
    if (self.timer == nil)
    {
        NSTimer *timer = [NSTimer timerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            if (self.progress >= 1)
            {
                self.progress = 0;
            }
            self.progress += 0.05;
            
        }];
        [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        
        self.timer = timer;
    }
}


-(void)endAnimate
{
    [self.displayLink invalidate];
    self.displayLink = nil;
    
    [self.timer invalidate];
    self.timer = nil;

}

-(void)cancelAnimate
{
    [self endAnimate];
    self.canAnimate = YES;

    self.progress = 0;
    [self makePath];
    self.shapeLayer.path = self.path.CGPath;
    
    [self displayLinkAction];
    
    
}

-(void)setUpLayer
{
    CAShapeLayer *layer =
    ({
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = self.path.CGPath;
        layer.fillColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3].CGColor;
        layer.bounds = self.BKImageView.frame;
        layer.anchorPoint = CGPointZero;
        self.shapeLayer =layer;
        layer;
    });
    
    [self.BKImageView.layer insertSublayer:layer above:self.BKImageView.layer];
}


/**这个方法为第一次启动动画做准备，创建了进度为0时的path，并让他成为上一次的path，下一次的path将会再次创建*/

-(void)setUpAnimate
{
    self.progress = 0.0;

    [self makePath];
    
    self.lastPath = self.path;
}

-(void)setUpSubViews
{
    UIImageView *imageView =
    ({
        UIImageView *imageView  = [[UIImageView alloc]initWithFrame:self.bounds];
        imageView.image = [UIImage imageNamed:@"home_choiness_banner_placeholder"];
        imageView.frame = CGRectMake((self.frame.size.width - imageView.ACwidth) * 0.5, 0, imageView.ACwidth, imageView.ACheight);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.BKImageView = imageView;
        imageView;
    });
    
    [self addSubview:imageView];
   
}

-(void)setUp
{
    self.clipsToBounds = YES;
}


#pragma mark - CAAnimationDelegate
/****************************************************************************************************************/

- (void)animationDidStart:(CAAnimation *)anim
{
    self.canAnimate = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        //之后上次动画结束了才开始下一次动画
        self.canAnimate =YES;
    }
}


#pragma mark - actiion
/****************************************************************************************************************/

-(void)displayLinkAction

{
    if (self.canAnimate)
    {
        [self makePath];
        
        self.animate.fromValue = (__bridge id _Nullable)(self.lastPath.CGPath);
        self.animate.toValue = (__bridge id _Nullable)(self.path.CGPath);
        
        
        [self.shapeLayer addAnimation:self.animate forKey:nil];
        
        self.lastPath = self.path;
    }
}

#pragma mark - dealloc
/****************************************************************************************************************/

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    
    [self.displayLink invalidate];
    self.displayLink = nil;
}

@end
