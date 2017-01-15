//
//  ViewController.m
//  XXImageLoopViewDemo
//
//  Created by tommy on 17/1/15.
//
//

#import "ViewController.h"

#import "XXImageLoopView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet XXImageLoopView *imageLoopView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:4];
    for (NSInteger i = 0; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", i+1]];
        [images addObject:image];
    }
    
    ActionBlock block = ^(NSInteger index){
        NSLog(@"点击了第张%ld图片", index);
    };
    
    // 方式一(初始化时提供全部参数)
    //    XXImageLoopView *imageLoopView = [[XXImageLoopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150) images:images interval:3.0 actionBlock:block];
    //    [self.view addSubview:imageLoopView];
    
    
    // 方式二(初始化时提供部分参数)
    //    XXImageLoopView *imageLoopView = [[XXImageLoopView alloc] initWithImages:images];
    //    imageLoopView.frame = CGRectMake(0, 0, self.view.frame.size.width, 150);
    //    [self.view addSubview:imageLoopView];
    
    // 方式三(初始化时不提供参数)
    XXImageLoopView *imageLoopView = [[XXImageLoopView alloc] init];
    imageLoopView.frame = CGRectMake(0, 0, self.view.frame.size.width, 150);
    imageLoopView.images = images;
    imageLoopView.pageControl.pageIndicatorTintColor = [UIColor greenColor];
    imageLoopView.pageControl.hidden = NO;
    imageLoopView.interval = 3.0;
    imageLoopView.actionBlock = block;
    imageLoopView.alignment = XXPageControlAlignmentBottomCenter;
    imageLoopView.leftOrRightMargin = 60;
    imageLoopView.bottomMargin = 15;
        [self.view addSubview:imageLoopView];
    
    // 方式四(XIB方式)
//    _imageLoopView.images = images;
//    _imageLoopView.actionBlock = block;
}


@end
