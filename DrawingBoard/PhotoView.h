//
//  Created by 张文晏
//  Copyright © 2016年 张文晏. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef void(^TempBlock)(UIImage *);


@interface PhotoView : UIView


@property (nonatomic, strong) UIImage *image;


// 用来传递 image
@property (nonatomic, copy) TempBlock tempBlock;

@end
