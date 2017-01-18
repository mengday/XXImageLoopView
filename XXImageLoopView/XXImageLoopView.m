//
//  XXImageLooper.m
//  iOSTest
//
//  Created by Macmini on 2017/1/12.
//  Copyright © 2017年 Macmini. All rights reserved.
//

#import "XXImageLoopView.h"


#define kCycleCount 3
#define kTimeInterval 5.0
#define kAnimateDuration 1.5
#define kBottomMargin 10


@interface XXImageLoopView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *middleImageView;  // 中间图片会始终在UIScrollView的中间位置
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) NSTimer *timer;

@end



@implementation XXImageLoopView

// 第一步：初始化子控件
// 第二步：自动布局
// 第三步：设置数据

#pragma mark - Init
- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 代码重复 提取
    [self setupUI];
    
    [self setupPropertyDefaultValue];
}

- (instancetype)imageLoopView {
    return [self initWithFrame:CGRectZero images:nil interval:kTimeInterval actionBlock:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame images:nil interval:kTimeInterval actionBlock:nil];
}

- (instancetype)initWithImages:(NSArray *)images {
    return [self initWithFrame:CGRectZero images:images interval:kTimeInterval actionBlock:nil];
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images {
    return [self initWithFrame:frame images:images interval:kTimeInterval actionBlock:nil];
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images interval:(NSTimeInterval)interval {
    
    return [self initWithFrame:frame images:images interval:interval actionBlock:nil];
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images interval:(NSTimeInterval)interval actionBlock:(ActionBlock)block {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];  // 初始化UI
        
        [self setupPropertyDefaultValue];  // 初始化属性的默认值
        
        _images = images;
        
        self.interval = interval;
        
        self.actionBlock = block;
    }
    
    return self;

}



- (void) setupUI {
    // 1. UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView = scrollView;
    [self addSubview:scrollView];
    
    // 2. Left Middle Right
    _leftImageView = [[UIImageView alloc] init];
    [scrollView addSubview:_leftImageView];
    
    _middleImageView = [[UIImageView alloc] init];
    [scrollView addSubview:_middleImageView];
    
    _rightImageView = [[UIImageView alloc] init];
    [scrollView addSubview:_rightImageView];
    
    // 3. 初始化默认为第一页
    _currentIndex = 0;
    
    
    // 4. UIPageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl = pageControl;
    [self addSubview:pageControl];
    
    // 5. 单击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self addGestureRecognizer:tapGesture];
}


// 初始化属性默认值
- (void)setupPropertyDefaultValue {
    self.alignment = XXPageControlAlignmentBottomCenter;  // 默认值
    self.interval = kTimeInterval;
    self.animateDuration = kAnimateDuration;
    self.bottomMargin = kBottomMargin;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    // UIScrollView
    _scrollView.frame = CGRectMake(0, 0, width, height);
    _scrollView.contentSize = CGSizeMake(width * kCycleCount, 0);
    _scrollView.contentOffset = CGPointMake(width, 0); // 设置偏移量，让middleImageView出现在屏幕上
    
    // Left|Middle|Right UIImageView
    _leftImageView.frame = CGRectMake(0, 0, width, height);
    _middleImageView.frame = CGRectMake(width, 0, width, height);
    _rightImageView.frame = CGRectMake(width * 2, 0, width, height);
    
    // UIPageControl
    CGFloat pageConntrolWidth = 15 * self.images.count;
    CGFloat x = 0;
    switch (self.alignment) {
        case XXPageControlAlignmentBottomCenter:
            x = (width - pageConntrolWidth) * 0.5 + pageConntrolWidth * 0.5;
            break;
        case XXPageControlAlignmentBottomLeft:
            x = self.leftOrRightMargin;
            break;
        case XXPageControlAlignmentBottomRight:
            x = width - (pageConntrolWidth + self.leftOrRightMargin);
            break;
        default:
            break;
    }
    
    _pageControl.frame = CGRectMake(x, height - self.bottomMargin, pageConntrolWidth, 0);
}


- (void)setImages:(NSArray *)images {
    _images = images;
    if (images == nil || images.count == 0) {
        NSException *exception = [NSException exceptionWithName:@"NSNullException"
                                                         reason:@"images Value is not allowed to be empty and count must > 0 " userInfo:nil];
        @throw exception;
    }
    
    _middleImageView.image = images[0];
    if (images.count > 1) {
        _rightImageView.image = images[1];
        _leftImageView.image = images[images.count - 1];
    }
    
    
    _pageControl.numberOfPages = images.count;
    
    [self setNeedsDisplay]; // 图片的数量影响UIPageControl的宽度
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 1. 重新设置left、right对应的图片
    [self resetImageForImageViews:scrollView.contentOffset.x];
    
    // 2. 恢复到初始化状态(最核心的逻辑)
    scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
}


// 开始拖拽时停止自动滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

// 拖动停止时恢复自动滚动功能
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startAutoScroll:self.interval];
}


// 重新设置新的图片
- (void) resetImageForImageViews:(CGFloat)offsetX {
    // 判断是左滑还是右滑，即确定当前操作时上一页还是下一页
    CGFloat width = self.frame.size.width;
//    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX == 2 * width) {  // 左滑：下一页
        if (_currentIndex == (_images.count - 1)) {
            _currentIndex = 0;
        } else {
            _currentIndex += 1;
        }
    } else if (offsetX == 0) {   // 右滑：上一页
        if (_currentIndex == 0) {
            _currentIndex = _images.count - 1;
        } else {
            _currentIndex -= 1;
        }
    }
    
    _pageControl.currentPage = _currentIndex;
    
    // 1. 修改left、middle、right对应的图片
    _middleImageView.image = _images[_currentIndex];
    if (_currentIndex  - 1 == -1) { // 防止索引出界
        _leftImageView.image = _images[_images.count - 1];
    } else {
        _leftImageView.image = _images[_currentIndex - 1];
    }
    
    
    if (_currentIndex + 1 == _images.count) {  // 防止索引出界
        _rightImageView.image = _images[0];
    } else {
        _rightImageView.image = _images[_currentIndex + 1];
    }
}


- (void)setInterval:(NSTimeInterval)interval {
    _interval = interval;
    if (self.timer != nil) {
        [self.timer invalidate];
    }
    
    [self startAutoScroll:interval];
}


- (void)startAutoScroll:(NSTimeInterval)interval {
    _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(loopImageTimer) userInfo:nil repeats:YES];
}


- (void)loopImageTimer {
    // 1. 先滚动
    // 2. 再替换图片
    // 3. 最后恢复偏移量
    CGPoint offset = CGPointMake(self.frame.size.width * 2, 0);
    
    [UIView animateWithDuration:self.animateDuration animations:^{
        self.scrollView.contentOffset = offset;
    } completion:^(BOOL finished) {
        [self resetImageForImageViews:offset.x];
        
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }];
}


- (void)tapGesture:(UITapGestureRecognizer *)tapGesture {
    if (self.actionBlock != nil) {
        self.actionBlock(_currentIndex);
    }
}
@end
