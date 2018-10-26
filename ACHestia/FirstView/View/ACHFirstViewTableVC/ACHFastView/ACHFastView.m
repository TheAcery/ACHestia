//
//  ACHFastView.m
//  ACHestia
//
//  Created by Acery on 2018/10/15.
//  Copyright © 2018年 Acery. All rights reserved.


/**
 * 这个view描述了ACHFirstViewTableView位于tableView头部的视图，随着tablrView的滚动而滚动
 * 在对这个view的subView创建了占位视图之后，每个视图都有自己的逻辑要处理，可能需要创建代理，但是我们希望他分开管理这些视图
 * 为了分开管理这些视图的逻辑，我为他们创建了独立的代理对象，同时在类中创建了强引用的指针指向他们，保证了在这个view存在的时候代理对象一定存在。
 */


/**
 * 这个视图挺复杂的，使用占位视图来模块化整个视图，这个视图包括了四个部分
 * 最上面的bigScrollView、中间的跳转按钮和精选品牌滚动视图、最下面的滚动视图（按钮是他们的索引指示）
 * 所以我们需要四个视图，每个占位视图中的详细内容都有其他的类去描述
 * 既然这个视图中有很多的滚动视图，我们可以创建他们的父类来设置一些公共的属性和功能，比如无限滚动 --> jump
 * 创建完视图之后我们需要为他添加功能，包括事件的传递，delegate
 */


#import "ACHFastView.h"

//view
#import "ACHFactViewBigScrollView.h"
#import "ACHFastViewJumpView.h"
#import "ACHFastViewMiddleView.h"
#import "ACHFastViewSmallScrollView.h"
#import "ACHFastViewSmallScrollViewCell.h"

//item
#import "ACHSmallScrollViewCellItem.h"


@interface ACHFastView () <UIScrollViewDelegate,ACHFastViewJumpViewDelegate,UIScrollViewDelegate,ACHScrollViewLoopScroDelegate>


/**最大的滚动占位视图*/
@property (weak, nonatomic) IBOutlet UIView *bigView;

/**中间跳转按钮的占位视图*/
@property (weak, nonatomic) IBOutlet UIView *jumpView;

/**中间的滚动占位视图*/
@property (weak, nonatomic) IBOutlet UIView *middleView;

/**下面小的滚动占位视图*/
@property (weak, nonatomic) IBOutlet UIView *smallScrollView;


//REALLY VIEWS
@property (nonatomic, weak) ACHFactViewBigScrollView *reBigView;
@property (nonatomic, weak) ACHFastViewJumpView *reJumpView;
@property (nonatomic, weak) ACHFastViewMiddleView *reMiddleView;
@property (nonatomic, weak) ACHFastViewSmallScrollView *reSmallScrollView;

//OTHER
@property (nonatomic, weak) NSTimer *scrollViewAutoScrollTimer;


@end

@implementation ACHFastView

+(instancetype)fastView
{
    return [[NSBundle mainBundle]loadNibNamed:@"ACHFastView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
   
    [self setAllSubViews];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - setSubViews
/****************************************************************************************************************/

-(void)setAllSubViews
{
    //bigView
   
    [self setUpbBigView];
    
    //jumpView
    
    [self setUpJumpView];
    
    //middleView
    
   
    [self setUpMiddleView];
    
    //smallView
    
    [self setUpSmallScrollView];
}

#pragma mark - funs
/****************************************************************************************************************/

//setUpbigView
-(void)setUpbBigView
{
    ACHFactViewBigScrollView *bigScrollView =
    ({
        //创建子视图和ACHFactViewBigScrollView对象
        NSMutableArray *views = [NSMutableArray array];
        for (int subViews = 0; subViews < 4; subViews++)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, self.bigView.ACheight)];
            imageView.image = [UIImage imageNamed:@"ORIimage"];
            
            [views addObject:imageView];
        }
        
        ACHFactViewBigScrollView *bigScrollView = [ACHFactViewBigScrollView scrollViewWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, self.bigView.ACheight) Views:views];
        
        self.reBigView = bigScrollView;
        bigScrollView;
    });
    
    [self.bigView addSubview:bigScrollView];
    //开启自动滚动
    [self scrollViewAutoScroll:2.0];
    
    //设置代理
    bigScrollView.delegate = self;
    bigScrollView.loopScrollDelegate = self;
}


//setUpjumpView

-(void)setUpJumpView
{
    ACHFastViewJumpView *jumpView =
    ({
        ACHFastViewJumpView *jumpView = [ACHFastViewJumpView fastViewJumpView];
        jumpView.frame = self.jumpView.bounds;
        jumpView.delegate = self;
        jumpView;
    });
    
    [self.jumpView addSubview:jumpView];
    
    //抛出事件，这个方法从ACHFastViewJumpView代理抛到ACHFastView，然后传递到ACHFirstViewTableVC
}

//setUpMiddleView

-(void)setUpMiddleView
{
    ACHFastViewMiddleView *middleView =
    ({
        
        ACHFastViewMiddleView *middleView = [[ACHFastViewMiddleView alloc]init];
        middleView.frame = self.middleView.bounds;
        
        middleView;
    });
    
    [self.middleView addSubview:middleView];
    
    //因为这个视图需要自动滚动，所以也需要设置代理，但是不需要把事件抛出
}

//setUpSmallScrollView
-(void)setUpSmallScrollView
{
    ACHFastViewSmallScrollView *smallView =
    ({
        
        //create all cells
        NSMutableArray *views = [NSMutableArray array];
        
        for (NSInteger count = 0; count < 6; count ++)
        {
            
            ACHSmallScrollViewCellItem *item = [[ACHSmallScrollViewCellItem alloc]init];
            item.imageName = @"ORIimage";
            item.title = @"外婆家";
            item.distance = @"最近一家店距你2.1km";
            item.discount = @"5.0";
            
            ACHFastViewSmallScrollViewCell *cell = [ACHFastViewSmallScrollViewCell smallScrollViewCellWithItem:item];
            cell.frame = CGRectMake(10, 0, SCRENNBOUNDS.size.width - 20, cell.ACheight);
            
            //增加contentView来保证ACHFastViewSmallScrollViewCell始终保持缩进
            UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCRENNBOUNDS.size.width, cell.ACheight)];
            contentView.backgroundColor = UIColor.yellowColor;
            
            //debug
            UILabel *page = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            
            NSInteger pageNumber = count + 1;
            page.text = [NSString stringWithFormat:@"%zd",pageNumber];
            page.textColor = UIColor.blackColor;
            
            [contentView addSubview:page];
            
            [contentView addSubview:cell];
            
            [views addObject:contentView];
        }
        
        //create ACHFastViewSmallScrollView object
        ACHFastViewSmallScrollView *smallView = [[ACHFastViewSmallScrollView alloc]init];
        smallView.views = views;
        smallView.frame = CGRectMake(0, 0, self.smallScrollView.ACwidth, self.smallScrollView.ACheight);
        smallView;
    });
    
    [self.smallScrollView addSubview:smallView];
    //设置代理，监听事件

    
}

//开启bigScrollView的自动滚动
-(void)scrollViewAutoScroll:(CGFloat)timerInterval
{
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:timerInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self.reBigView pageIsUp:YES];
    }];
    
    
    
    self.scrollViewAutoScrollTimer = timer;
    
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

//关闭bigScrollView的自动滚动
-(void)scrollViewCancelAutoScroll
{
    [self.scrollViewAutoScrollTimer invalidate];
}


#pragma mark - ACHFastViewJumpViewDelegate
/****************************************************************************************************************/

/**
 * 继续传递事件到控制器
 */

/**在FirstButton被点击到时候调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view FirstButtonClip:(ACHButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(didFastViewJumpView:FirstButtonClip:)])
    {
        [self.delegate didFastViewJumpView:view FirstButtonClip:btn];
    }
}

/**在CutDownButton被点击到时候调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view CutDownButtonClip:(ACHButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(didFastViewJumpView:CutDownButtonClip:)])
    {
        [self.delegate didFastViewJumpView:view CutDownButtonClip:btn];
    }
}

/**在BrandButton被点击到时候调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view BrandButtonClip:(ACHButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(didFastViewJumpView:BrandButtonClip:)])
    {
        [self.delegate didFastViewJumpView:view BrandButtonClip:btn];
    }
}

/**在DelicacyButton被点击到时候调用*/
-(void)didFastViewJumpView:(ACHFastViewJumpView *)view DelicacyButtonClip:(ACHButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(didFastViewJumpView:DelicacyButtonClip:)])
    {
        [self.delegate didFastViewJumpView:view DelicacyButtonClip:btn];
    }
}

#pragma mark - UIScrollViewDelegate
/****************************************************************************************************************/

/**
 * 监听bigScrollView的滚动，判断定时器的开始和结束
 */

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
        [self scrollViewAutoScroll:2.0];
    }
    
    
}

#pragma mark - ACHScrollViewLoopScroDelegate
/****************************************************************************************************************/


/**
 * 监听当前自动滚动到pageCount
 */
-(void)didACHScrollView:(ACHScrollView *)ACHScrollView ScrollAtViewWithIndex:(NSInteger)index
{
    
}
@end
