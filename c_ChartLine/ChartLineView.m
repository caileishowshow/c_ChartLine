//
//  ChartLineView.m
//  c_ChartLine
//  折线图主界面
//  Created by cailei on 15/7/9.
//  Copyright (c) 2015年 cailei. All rights reserved.
//

#import "ChartLineView.h"

@implementation ChartLineView{
    NSArray *left_titles;
    NSArray *buttom_titles;
}


#define PADDING 10//边界
#define LEFT_SCALE 50//左边界刻度宽度
#define BUTTOM_SCALE 20//底部高度

//- (instancetype)init{
//    
//    if ([super init]) {
//        left_titles = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
//    }
//    
//    
//    return self;
//}


//画图界面
- (void)drawRect:(CGRect)rect {
    
    left_titles = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    buttom_titles = @[@"7/1",@"7/2",@"7/3",@"7/4",@"7/5",@"7/6",@"7/7"];
    //整个框架的宽高
    CGFloat availableWidth = self.bounds.size.width-2*PADDING-LEFT_SCALE;//宽
    CGFloat availableHeight = self.bounds.size.height - 2*PADDING-BUTTOM_SCALE;//高
    //边框的起始点
    CGFloat xStart = PADDING+LEFT_SCALE;
    int x = 7;//横着画七行
    int y = 7;//竖着画五行


    //首先画边框，整个页面画一个边框
    CGContextRef c = UIGraphicsGetCurrentContext();//上下文
    //画横线
    for (int i=0;i<x;i++) {
        CGMutablePathRef path = CGPathCreateMutable();//句柄
        CGPathMoveToPoint(path, NULL, xStart, PADDING+(i*availableHeight)/(x-1));
        CGPathAddLineToPoint(path, NULL,xStart+availableWidth, PADDING+(i*availableHeight)/(x-1));
        CGContextAddPath(c, path);
        CGContextSetStrokeColorWithColor(c, [[UIColor darkGrayColor] CGColor]);//设置颜色
        CGContextStrokePath(c);
        CGPathRelease(path);
    }
    //画竖线
    for (int i=0; i<y; i++) {
        CGMutablePathRef path = CGPathCreateMutable();//句柄
        CGPathMoveToPoint(path, NULL, xStart+(i*availableWidth)/(y-1), PADDING);
        CGPathAddLineToPoint(path, NULL, xStart+(i*availableWidth)/(y-1), PADDING+availableHeight);
        CGContextAddPath(c, path);
        CGContextSetStrokeColorWithColor(c, [[UIColor darkGrayColor] CGColor]);//设置颜色
        CGContextStrokePath(c);
        CGPathRelease(path);
    }
    //第二部，画边上的刻度
    for (int i=0;i<[left_titles count];i++) {//先画左边的刻度
        NSString *left_title = left_titles[i];
        [left_title drawInRect:CGRectMake(PADDING+20, PADDING+(i*availableHeight)/(x-1)-10, LEFT_SCALE, 20) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    }
    //再画底下的刻度
    for (int i=0; i<[buttom_titles count]; i++) {
        NSString *buttom_title = buttom_titles[i];
        [buttom_title drawInRect:CGRectMake(xStart+(i*availableWidth)/(y-1)-15, PADDING+availableHeight+2, 30, BUTTOM_SCALE) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    }
}


@end
