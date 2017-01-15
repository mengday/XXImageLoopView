# XXImageLoopView

![示例效果图](http://img.blog.csdn.net/20170115161307910?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdmJpcmRiZXN0/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

###XXImageLoopView

一个快速集成图片轮播功能的自定义控件


---
### Installation【安装】

#### CocoaPods【使用CocoaPods】
```objc
pod 'XXImageLoopView'
```

#### Manually【手动导入】

1. 将XXImageLoopView文件夹拖入到自己的工程中
2. 在使用的视图控制器中导入头文件 ``` #import "XXImageLoopView.h" ```

---

### Getting Started【开始使用】

1. 将XXImageLoopView文件夹拖入到自己的工程中
2. 创建XXImageLoopView并添加到父视图中

---
### Examples【示例】

#### 一 ：纯代码方式
```objc
// 方式一(初始化时提供全部参数)
XXImageLoopView *imageLoopView = [[XXImageLoopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150) images:images interval:3.0 actionBlock:block];
[self.view addSubview:imageLoopView];
    
    
// 方式二(初始化时提供部分参数)
XXImageLoopView *imageLoopView = [[XXImageLoopView alloc] initWithImages:images];
imageLoopView.frame = CGRectMake(0, 0, self.view.frame.size.width, 150);
[self.view addSubview:imageLoopView];
    
// 方式三(初始化时不提供参数)
XXImageLoopView *imageLoopView = [[XXImageLoopView alloc] init];
imageLoopView.frame = CGRectMake(0, 0, self.view.frame.size.width, 150);
imageLoopView.images = images;
imageLoopView.pageControl.pageIndicatorTintColor = [UIColor greenColor];
imageLoopView.pageControl.hidden = NO;
imageLoopView.interval = 3.0;
imageLoopView.actionBlock = block;
imageLoopView.alignment = XXPageControlAlignmentBottomRight;
imageLoopView.leftOrRightMargin = 60;
imageLoopView.bottomMargin = 15;
[self.view addSubview:imageLoopView];
```

#### 二：XIB方式
```objc
// 方式四(XIB方式)
_imageLoopView.images = images;
_imageLoopView.actionBlock = block;
```

---
### Detailed Introduction【详细介绍】
[自定义轮播视图的实现思路的详细介绍](http://blog.csdn.net/vbirdbest/article/details/54562286)

---
### Expect【期待】

- 如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的框架代码看看BUG修复没有）
- 如果在使用过程中发现功能不够用，希望你能Issues我，我非常想为这个框架增加更多好用的功能，谢谢
- 如果你想为XXImageLoopView输出代码，请拼命Pull Requests我




