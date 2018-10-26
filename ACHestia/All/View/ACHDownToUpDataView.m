//
//  ACHDownToUpData.m
//  ACHestia
//
//  Created by Acery on 2018/10/25.
//  Copyright © 2018年 Acery. All rights reserved.
//

#import "ACHDownToUpDataView.h"

#warning TODO 下拉刷新 make left and right

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

@property (assign, nonatomic) CGFloat progress;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) CABasicAnimation *animate;

@property (assign, nonatomic) BOOL canAnimate;

@end

@implementation ACHDownToUpDataView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        self.clipsToBounds = YES;
        self.canAnimate = YES;
        
//        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
//        displayLink.preferredFramesPerSecond = 50;
        
//        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        UIImageView *imageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_choiness_banner_placeholder"]];
        
         imageView.frame = CGRectMake((frame.size.width - imageView.ACwidth) * 0.5, 0, imageView.ACwidth, imageView.ACheight);
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
        self.BKImageView = imageView;
        
        
        UIBezierPath *path =
        ({
           UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, frame.size.height * 0.5)];
            [path addCurveToPoint:CGPointMake(frame.size.width, frame.size.height * 0.5) controlPoint1:CGPointMake(frame.size.width * 0.5, 0) controlPoint2:CGPointMake(frame.size.width* 0.5,frame.size.height)];
            
            [path addLineToPoint:CGPointMake(frame.size.width, frame.size.height)];
            [path addLineToPoint:CGPointMake(0, frame.size.height)];
            path;
        });
        
        self.lastPath = path;
        
        CAShapeLayer *layer =
        ({
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.path = path.CGPath;
            layer.fillColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3].CGColor;
            layer.bounds = imageView.frame;
            layer.anchorPoint = CGPointZero;
            self.shapeLayer =layer;
            layer;
        });
       
       [imageView.layer insertSublayer:layer above:imageView.layer];
        
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    [self makePath:0.5];
    
    self.animate.fromValue = (__bridge id _Nullable)(self.lastPath.CGPath);
    self.animate.toValue = (__bridge id _Nullable)(self.path.CGPath);
    
    [self.shapeLayer addAnimation:self.animate forKey:nil];
    
    self.lastPath = self.path;
}


#pragma mark - lazy init
/****************************************************************************************************************/

- (CABasicAnimation *)animate
{
    if (_animate == nil)
    {
        _animate = [CABasicAnimation animation];
        
        _animate.removedOnCompletion = NO;
        _animate.fillMode = kCAFillModeForwards;
        
        _animate.delegate = self;
        
        _animate.duration = 0.1;
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

-(void)makePath:(CGFloat )progress
{
    //总体高度，浪花的起始位置，结束位置可以用这个数值，为了真实也许会通过这个值计算得到结束的位置，加或减去一个随机值
    CGFloat heightStart = progress * self.frame.size.height;
    //浪花的结束高度
    CGFloat heightEnd = heightStart;
    
    /**
     * 通过两个贝塞尔曲线控制点的位置来控制浪花的起伏和水平位移
     * 第一个点的位移区间应该在width的左半边，第二个应该在右半边
     * 第一个点的高度区间应该在总体高度的固定幅度区间中取值，第二个也是，但是要保证他们不一致
     */
    
    CGFloat controlPointOneX = (arc4random() % (NSInteger)(self.ACwidth * 0.25)) + self.ACwidth * 0.25*0.5;
    CGFloat controlPointTwoX = (arc4random() % (NSInteger)(self.ACwidth * 0.25)) + (self.ACwidth * 0.25*0.5) + (self.ACwidth * 0.5) ;
    
    CGFloat controlPointOneY = heightStart - (arc4random() % (NSInteger)(self.ACheight * 0.25));//初始值
    CGFloat controlPointTwoY = controlPointOneY - (arc4random() % (NSInteger)(self.ACheight * 0.25));//初始值
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, heightStart)];
    [path addCurveToPoint:CGPointMake(self.ACwidth, heightEnd) controlPoint1:CGPointMake(controlPointOneX, controlPointOneY) controlPoint2:CGPointMake(controlPointTwoX, controlPointTwoY)];
    
    [path addLineToPoint:CGPointMake(self.ACwidth, self.ACheight)];
    [path addLineToPoint:CGPointMake(0, self.ACheight)];
    
    self.path = path;
}


-(void)makeAnimate
{
    self.animate = nil;
}

#pragma mark - CAAnimationDelegate
/****************************************************************************************************************/

- (void)animationDidStart:(CAAnimation *)anim
{
//    self.canAnimate = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    if (flag)
//    {
//        //之后上次动画结束了才开始下一次动画
//        self.canAnimate =YES;
//    }
}


#pragma mark - actiion
/****************************************************************************************************************/

-(void)displayLinkAction

{
    if (1)
    {
        
    }
}

@end
