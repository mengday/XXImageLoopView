//
//  XXCollectionViewCell.m
//  XXAutoLoopViewDemo
//
//  Created by Macmini on 2017/1/16.
//  Copyright © 2017年 Macmini. All rights reserved.
//

#import "XXCollectionViewCell.h"

@interface XXCollectionViewCell ()
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation XXCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}


- (void)setup {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 150)];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
}


//-(void)layoutSubviews {
//    [super layoutSubviews];
//    
//    
//}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = image;
}



@end
