//
//  Created by 张文晏
//  Copyright © 2016年 张文晏. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface DrawView : UIView

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, strong) UIImage *image;

// 回退
- (void)back;

// 清屏
- (void)clear;

// 橡皮
- (void)rubber;

@end
