//
//  XXImageLooper.h
//  iOSTest
//
//  Created by Macmini on 2017/1/12.
//  Copyright © 2017年 Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(NSInteger index);

typedef NS_ENUM(NSInteger, XXPageControlAlignment) {
    XXPageControlAlignmentBottomLeft      = 0,    // 底部左边
    XXPageControlAlignmentBottomCenter    = 1,    // 底部居中
    XXPageControlAlignmentBottomRight     = 2,    // 底部右边
};



@interface XXImageLoopView : UIView

/** 轮播的图片 */
@property (nonatomic, strong) NSArray *images;

/** 点击滚动的图片对应的代码块 */
@property (nonatomic, copy) ActionBlock actionBlock;

/** UIPageControl的显示位置, 默认值是XXPageControlAlignmentBottomCenter */
@property (nonatomic, assign) XXPageControlAlignment alignment;

/** 当alignment=Left|Right时UIPageControl距离父视图的外间距，默认为20*/
@property (nonatomic, assign) CGFloat leftOrRightMargin;

/** UIPageControl距离父视图的底部间距, 默认是10 */
@property (nonatomic, assign) CGFloat bottomMargin;

/** 定时器间隔时间, 默认为1秒 */
@property (nonatomic, assign) NSTimeInterval interval;

/** 动画周期：图片向左滑动的时间，默认1.5秒 */
@property (nonatomic, assign) CGFloat animateDuration;


@property (strong, nonatomic, readonly) UIPageControl *pageControl;



- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images interval:(NSTimeInterval)interval actionBlock:(ActionBlock)block;
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images interval:(NSTimeInterval)interval;
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images;
- (instancetype)initWithImages:(NSArray *)images;
- (instancetype)imageLoopView;


@end
