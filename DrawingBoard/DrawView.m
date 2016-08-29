//
//  Created by 张文晏
//  Copyright © 2016年 张文晏. All rights reserved.
//
#import "DrawView.h"
#import "WPBezierPath.h"

@interface DrawView()

@property (nonatomic, strong) WPBezierPath  *bezierPath;

@property (nonatomic, strong) NSMutableArray *pathArray;

@end

@implementation DrawView

#pragma mark
#pragma mark - 懒加载数组
- (NSMutableArray *)pathArray {
    if (nil == _pathArray) {
        _pathArray = [NSMutableArray array];
    }
    
    return _pathArray;
}

/**
 
 从文件中解档出来的时候, 就会自动调用
 - (instancetype)initWithCoder:(NSCoder *)coder
 {
 self = [super initWithCoder:coder];
 if (self) {
 
 }
 return self;
 }
 */

#pragma mark
#pragma mark - 初始化方法
- (void)awakeFromNib {
    
    _lineWidth = 1;
}

#pragma mark
#pragma mark - 开始触摸
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 获取点击的位置
    UITouch *touch = touches.anyObject;
    
    CGPoint touchPoint = [touch locationInView:touch.view];
    
    // 创建beizerPath
    WPBezierPath *bezierPath = [WPBezierPath bezierPath];
    
    // 设置线宽
    bezierPath.lineWidth = _lineWidth;
    
    // 记录当前path的 颜色
    bezierPath.lineColor = _lineColor;
    
    // 添加点
    [bezierPath moveToPoint:touchPoint];
    
    self.bezierPath = bezierPath;
    
    // 把bezierPath 添加到数组
    [self.pathArray addObject:bezierPath];
    
    
}

#pragma mark
#pragma mark - 手指滑动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 获取点击的位置
    UITouch *touch = touches.anyObject;
    
    CGPoint movePoint = [touch locationInView:touch.view];
    
    [self.bezierPath addLineToPoint:movePoint];
    
    
    // 重绘
    [self setNeedsDisplay];
}


#pragma mark
#pragma mark - 重写图片的set方法
- (void)setImage:(UIImage *)image {
    _image = image;
    
    //    _bezierPath.image = image;]
    
    // 创建一个新的bezierPath
    WPBezierPath *bezierPath = [WPBezierPath bezierPath];
    
    bezierPath.image = image;
    
    // 把path 添加到数组中
    [self.pathArray addObject:bezierPath];
    
    // 重绘
    [self setNeedsDisplay];
}



#pragma mark
#pragma mark - 绘制界面
- (void)drawRect:(CGRect)rect {
    
    for (WPBezierPath *path in self.pathArray) {
        
        if (path.image) {
            
            [path.image drawAtPoint:CGPointZero];
        } else {
            
            // 取出path中的颜色, 进行设置
            [path.lineColor set];
            
            
            [path stroke];
        }
    }
    
    //    if (_image) {
    //        [_image drawAtPoint:CGPointZero];
    //    }
}


#pragma mark
#pragma mark - 回退
- (void)back {
    
    [self.pathArray removeLastObject];
    
    [self setNeedsDisplay];
    
}


#pragma mark
#pragma mark - 清屏
- (void)clear {
    
    [self.pathArray removeAllObjects];
    
    [self setNeedsDisplay];
    
}


- (void)rubber {
    
    _lineColor = self.backgroundColor;
    
}


@end
