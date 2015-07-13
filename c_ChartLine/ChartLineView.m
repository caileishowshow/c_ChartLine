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
    NSArray *dataArray;//结果数组
    Float32 up,down;//两个值，上边界和下边界
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
    
    up = 15.5;
    down = 8.5;
    
    dataArray = @[@{@"value":@"15.5",@"data":@"7/1"},@{@"value":@"10.2",@"data":@"7/2"},@{@"value":@"10.2",@"data":@"7/3"},@{@"value":@"10.2",@"data":@"7/4"},@{@"value":@"11",@"data":@"7/5"},@{@"value":@"10.2",@"data":@"7/6"},@{@"value":@"9",@"data":@"7/7"}];
    
    
   
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
        CGContextSetStrokeColorWithColor(c, [[UIColor colorWithWhite:240/255.0 alpha:1] CGColor]);//设置颜色
        CGContextStrokePath(c);
        CGPathRelease(path);
    }
    //画竖线
    for (int i=0; i<y; i++) {
        CGMutablePathRef path = CGPathCreateMutable();//句柄
        CGPathMoveToPoint(path, NULL, xStart+(i*availableWidth)/(y-1), PADDING);
        CGPathAddLineToPoint(path, NULL, xStart+(i*availableWidth)/(y-1), PADDING+availableHeight);
        CGContextAddPath(c, path);
        CGContextSetStrokeColorWithColor(c, [[UIColor colorWithWhite:240/255.0 alpha:1] CGColor]);//设置颜色
        CGContextStrokePath(c);
        CGPathRelease(path);
    }
    //第二部，画边上的刻度
    for (int i=0;i<[left_titles count];i++) {//先画左边的刻度
        NSString *left_title = left_titles[i];
        [left_title drawInRect:CGRectMake(PADDING+20, PADDING+(i*availableHeight)/(x-1)-10, LEFT_SCALE, 20) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    }
    //再画底下的刻度
    for (int i=0; i<[dataArray count]; i++) {
        NSString *buttom_title = dataArray[i][@"data"];
        [buttom_title drawInRect:CGRectMake(xStart+(i*availableWidth)/(y-1)-15, PADDING+availableHeight+2, 30, BUTTOM_SCALE) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    }
    //第三部 画点
    for (int i=0; i<[dataArray count]; i++) {
        Float32 count_num = [dataArray[i][@"value"] floatValue];
        CGContextSetFillColorWithColor(c, [UIColor colorWithRed:255/255.0 green:159/255.0 blue:56/255.0 alpha:1].CGColor);
        CGContextFillEllipseInRect(c, CGRectMake(xStart+(i*availableWidth)/(y-1)-6, (1-(count_num/(up)))*availableHeight+PADDING-6, 10, 10));
    }
    
    //第四部 设置底部区域的颜色
    {
        CGMutablePathRef path = CGPathCreateMutable();//句柄
//        CGPathMoveToPoint(path, NULL, xStart+(0*availableWidth)/(y-1), (1-([dataArray[0][@"value"] floatValue]/(up)))*availableHeight+PADDING);
        CGContextMoveToPoint(c, xStart+(0*availableWidth)/(y-1), (1-([dataArray[0][@"value"] floatValue]/(up)))*availableHeight+PADDING);
        for (int i=0; i<y-1; i++) {
             CGContextAddLineToPoint(c, xStart+((i+1)*availableWidth)/(y-1), (1-([dataArray[i+1][@"value"] floatValue]/(up)))* availableHeight+PADDING);
            
//            CGContextAddPath(c, path);
//            CGContextSetStrokeColorWithColor(c, [[UIColor clearColor] CGColor]);//设置颜色
//            CGContextStrokePath(c);
            
        }
        
        CGContextAddLineToPoint(c,xStart+((y-1)*availableWidth)/(y-1), PADDING+availableHeight);
        CGContextAddLineToPoint(c, xStart+(0*availableWidth)/(y-1), PADDING+availableHeight);
        
        CGContextClosePath(c);
        CGContextSetFillColorWithColor(c, [UIColor colorWithRed:255/255.0 green:159/255.0 blue:56/255.0 alpha:0.1].CGColor);
        CGContextFillPath(c);
        CGPathRelease(path);
    
    }
    //第五部画线
    {
        
        for (int i=0; i<y-1; i++) {
            CGMutablePathRef path = CGPathCreateMutable();//句柄
            CGPathMoveToPoint(path, NULL, xStart+(i*availableWidth)/(y-1), (1-([dataArray[i][@"value"] floatValue]/(up)))*availableHeight+PADDING);
            CGPathAddLineToPoint(path, NULL, xStart+((i+1)*availableWidth)/(y-1), (1-([dataArray[i+1][@"value"] floatValue]/(up)))*availableHeight+PADDING);
            CGContextAddPath(c, path);
            CGContextSetStrokeColorWithColor(c, [UIColor colorWithRed:255/255.0 green:159/255.0 blue:56/255.0 alpha:1].CGColor);//设置颜色
            CGContextStrokePath(c);
            CGPathRelease(path);
        }
    }
}

//接下来增加点击事件


@end
