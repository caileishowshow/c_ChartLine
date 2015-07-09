//
//  ChartLineView.m
//  c_ChartLine
//  折线图主界面
//  Created by cailei on 15/7/9.
//  Copyright (c) 2015年 cailei. All rights reserved.
//

#import "ChartLineView.h"

@implementation ChartLineView


#define PADDING 10//边界

//画图界面
- (void)drawRect:(CGRect)rect {
    
    
    //整个框架的宽高
    CGFloat availableWidth = self.bounds.size.width-2*PADDING;//宽
    CGFloat availableHeight = self.bounds.size.height - 2*PADDING;//高
    
    
    int x = 7;//横着花七行
    int y = 7;//竖着画五行


    //首先画边框，整个页面画一个边框
    CGContextRef c = UIGraphicsGetCurrentContext();//上下文
    //画横线
    for (int i=0;i<x;i++) {
        CGMutablePathRef path = CGPathCreateMutable();//句柄
        CGPathMoveToPoint(path, NULL, PADDING, PADDING+(i*availableHeight)/(x-1));
        CGPathAddLineToPoint(path, NULL,PADDING+availableWidth, PADDING+(i*availableHeight)/(x-1));
        CGContextAddPath(c, path);
        CGContextSetStrokeColorWithColor(c, [[UIColor darkGrayColor] CGColor]);//设置颜色
        CGContextStrokePath(c);
        CGPathRelease(path);
    }
    //画竖线
    for (int i=0; i<y; i++) {
        CGMutablePathRef path = CGPathCreateMutable();//句柄
        CGPathMoveToPoint(path, NULL, PADDING+(i*availableWidth)/(y-1), PADDING);
        CGPathAddLineToPoint(path, NULL, PADDING+(i*availableWidth)/(y-1), PADDING+availableHeight);
        CGContextAddPath(c, path);
        CGContextSetStrokeColorWithColor(c, [[UIColor darkGrayColor] CGColor]);//设置颜色
        CGContextStrokePath(c);
        CGPathRelease(path);
    }
    //第二部，画边上的刻度
}


@end
