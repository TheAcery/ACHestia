//
//  ACHFastView.m
//  ACHestia
//
//  Created by Acery on 2018/10/15.
//  Copyright © 2018年 Acery. All rights reserved.
//  这个view描述了ACHFirstViewTableView位于tableView头部的视图，随着tablrView的滚动而滚动

#warning TODO 重写


/**
 * 这个视图挺复杂的，使用占位视图来模块化整个视图，这个视图包括了四个部分
 * 最上面的bigScrollView、中间的跳转按钮和精选品牌滚动视图、最下面的滚动视图（按钮是他们的索引指示）
 * 所以我们需要四个视图，每个占位视图中的详细内容都有其他的类去描述
 * 既然这个视图中有很多的滚动视图，我们可以创建他们的父类来设置一些公共的属性和功能，比如无限滚动 --> jump
 * 创建完视图之后我们需要为他添加功能，包括事件的传递，delegate
 */


#import "ACHFastView.h"

//view
#import "ACHSmallScrollViewCell.h"

//item
#import "ACHSmallScrollViewCellItem.h"

@interface ACHFastView () <UIScrollViewDelegate>


#warning TODO  整理代码

#pragma mark - scrollViews
/****************************************************************************************************************/

@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *smallScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *lineScrollView;
#pragma mark - buttons
/****************************************************************************************************************/

@property (weak, nonatomic) IBOutlet UIButton *bigButton1;
@property (weak, nonatomic) IBOutlet UIButton *bigButton2;
@property (weak, nonatomic) IBOutlet UIButton *bigButton3;
@property (weak, nonatomic) IBOutlet UIButton *bigButton4;


@property (weak, nonatomic) IBOutlet UIButton *samllButton1;
@property (weak, nonatomic) IBOutlet UIButton *samllButton2;
@property (weak, nonatomic) IBOutlet UIButton *samllButton3;
@property (weak, nonatomic) IBOutlet UIButton *samllButton4;

#pragma mark - inti funs
/****************************************************************************************************************/

@property (nonatomic, weak) NSTimer *timer;

@end

@implementation ACHFastView

+(instancetype)fastView
{
    return [[NSBundle mainBundle]loadNibNamed:@"ACHFastView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    /**设置bigScrollView*/
    [self setUpBigScrollerViewAndScroll];
    /**设置smallScrollView*/
    [self setUpsSmallScrollerViewAndScroll];

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
                          
#pragma mark - funs
/****************************************************************************************************************/

/**bigScrollView*/

-(void)makeBigScrollViewNetPage
{
    CGFloat bigScrollViewContentOffsetX = self.bigScrollView.contentOffset.x;
    CGFloat nextPage = 0.0;
    
    if (bigScrollViewContentOffsetX  >= self.bigScrollView.frame.size.width * 3)
    {
        nextPage = 0.0;
    }
    else
    {
        nextPage = bigScrollViewContentOffsetX + self.bigScrollView.frame.size.width;
    }
    
    [self.bigScrollView setContentOffset:CGPointMake(nextPage, 0) animated:YES];
}

-(void)setUpBigScrollerViewAndScroll
{
    
    //重新确定大小
    self.bigScrollView.bounds = CGRectMake(0, 0, SCRENNBOUNDS.size.width, self.bigScrollView.ACheight);
    /**让bigScrollView自动滚动*/
    
    //set bigScrollView delegate
    self.bigScrollView.delegate = self;
    
    //add image to bigScrollView
    for (int i = 0; i < 4; i++)
    {
        UIImageView *imageView =
        ({
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * self.bigScrollView.frame.size.width, 0, self.bigScrollView.frame.size.width, self.bigScrollView.frame.size.height)];
            imageView.image = [UIImage imageNamed:@"ORIimage"];
            imageView;
        });
        
        [self.bigScrollView addSubview:imageView];
    }
    self.bigScrollView.contentSize = CGSizeMake(self.bigScrollView.frame.size.width * 4, 0);
    
    // init timer
    [self initBigScrollViewTimer];
    
    
    /**判断在用户拖动的时候停止自动滚动，在停止滚动的时候开启自动滚动*/
}

-(void)initBigScrollViewTimer
{
    // init timer
    NSTimer *timer =
    ({
        NSTimer *timer = [[NSTimer alloc]initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:2.0] interval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self makeBigScrollViewNetPage];
        }];
        self.timer = timer;
        timer;
    });
    
    NSRunLoop *runloop = [NSRunLoop mainRunLoop];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
}

/**lineScrollView*/




/**smallScrollView*/




-(void)setUpsSmallScrollerViewAndScroll
{
    
    //重新确定大小
    self.smallScrollView.bounds = CGRectMake(0, 0, SCRENNBOUNDS.size.width, self.smallScrollView.ACheight);
    
    for (int i = 0; i < 5; i++)
    {
        //init items
        ACHSmallScrollViewCellItem *item =
        ({
            ACHSmallScrollViewCellItem *item = [[ACHSmallScrollViewCellItem alloc]init];
            item.imageName = @"ORIimage";
            item.title = @"川味观";
            item.discount = @"5.0";
            item.distance = @"最近一家店距你1.3km";
            item;
        });
        
        //cellView
        ACHSmallScrollViewCell *cell =
        ({
            ACHSmallScrollViewCell *cell = [ACHSmallScrollViewCell smallScrollViewCellWithItem:item];
            cell.frame = CGRectMake((self.smallScrollView.frame.size.width * i) + 10, 0, self.smallScrollView.frame.size.width - 20, cell.frame.size.height);
            cell;
        });
        
        //add to smallScrollView
        [self.smallScrollView addSubview:cell];
    }
    
    self.smallScrollView.contentSize = CGSizeMake(self.smallScrollView.frame.size.width * 5, 0);
}




#pragma mark - UIScrollViewDelegate
/****************************************************************************************************************/

//在用户拖拽bigScrollView停止自动滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //停止定时器
    [self.timer invalidate];
    NSLog(@"stop");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //开启计时器
    if (![scrollView isDragging])
    {
        [self initBigScrollViewTimer];
        NSLog(@"start");
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}

@end
