//
//  ViewController.m
//  XXAutoLoopViewDemo
//
//  Created by Macmini on 2017/1/16.
//  Copyright © 2017年 Macmini. All rights reserved.
//

#import "TestViewController.h"
#import "XXCollectionViewCell.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface TestViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *images;
@property (weak, nonatomic) UIPageControl *pageControl;
@property (weak, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation TestViewController

NSString * const ID = @"XXAutoLoopView";
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    [self.view addSubview:containerView];
    
    
    _images = [NSMutableArray arrayWithCapacity:4];
    for (NSInteger i = 0; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", i+1]];
        [_images addObject:image];
    }
    
    // 扩充数据
    [_images addObject:_images[0]]; // 将第一个数据添加到最后
    [_images insertObject:_images[_images.count - 2] atIndex:0]; // 将原始最后一个（也就是现在的倒数第二个）添加到第一位置
    
   
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = containerView.frame.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:containerView.frame collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    [collectionView registerClass:[XXCollectionViewCell class] forCellWithReuseIdentifier:ID];
    collectionView.contentOffset = CGPointMake(ScreenWidth, 0);
   
    
    self.collectionView = collectionView;
    [containerView addSubview:collectionView];
    
    
    // UIPageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 130, ScreenWidth, 0)];
    pageControl.pageIndicatorTintColor = [UIColor greenColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.numberOfPages = _images.count - 2;
    pageControl.currentPage = 0;
    self.pageControl = pageControl;
    [containerView addSubview:pageControl];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(loopImageTimer) userInfo:nil repeats:YES];
}

- (void)loopImageTimer {
    int offsetCount =  self.collectionView.contentOffset.x / ScreenWidth;
    
    CGFloat offsetX = self.collectionView.contentOffset.x;

#warning 当滚动最后一个图片时会间隔2倍Interval，有个小bug
    NSInteger row = offsetCount + 1;
    if (row == self.images.count - 1) {
        self.collectionView.contentOffset = CGPointMake(0, 0);
    } else {
        [UIView animateWithDuration:2.0 animations:^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            
            NSLog(@"offsetX=%f, offsetCount=%d, row=%ld, currentPage=%d", offsetX, offsetCount, row, offsetCount);
        } completion:^(BOOL finished) {
            
        }];
    }
    
    
    self.pageControl.currentPage = offsetCount;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.image = _images[indexPath.item];
    
    return cell;
}

// 开始拖拽时停止自动滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

// 拖动停止时恢复自动滚动功能
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(loopImageTimer) userInfo:nil repeats:YES];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 向左滑动，查看后面的图片
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat maxOffsetX = (self.images.count - 1) * ScreenWidth;
    NSLog(@"scrollViewDidEndDecelerating=%f", offsetX);
    if (offsetX == 0) { // 第一张
        self.collectionView.contentOffset = CGPointMake(maxOffsetX - ScreenWidth, 0);
        self.pageControl.currentPage = self.pageControl.numberOfPages - 1;
        
        return;
    } else if (offsetX == maxOffsetX) {  // 最后一张
        self.collectionView.contentOffset = CGPointMake(ScreenWidth, 0);
        self.pageControl.currentPage = 0;
        
        return;
    }

    
    self.pageControl.currentPage = (scrollView.contentOffset.x - ScreenWidth) / ScreenWidth;
}





@end
