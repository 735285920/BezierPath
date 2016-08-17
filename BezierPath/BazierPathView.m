//
//  BazierPathView.m
//  BezierPath
//
//  Created by shumei on 16/8/5.
//  Copyright © 2016年 ym. All rights reserved.
//

/*
 1,CAShapeLayer继承自CALayer，可使用CALayer的所有属性
 2,CAShapeLayer需要和贝塞尔曲线配合使用才有意义。
 贝塞尔曲线可以为其提供形状，而单独使用CAShapeLayer是没有任何意义的。
 3,使用CAShapeLayer与贝塞尔曲线可以实现不在view的DrawRect方法中画出一些想要的图形
 
 DrawRect：DrawRect属于CoreGraphic框架，占用CPU，消耗性能大
 CAShapeLayer：CAShapeLayer属于CoreAnimation框架，通过GPU来渲染图形，节省性能。动画渲染直接提交给手机GPU，不消耗内存
 
 贝塞尔曲线与CAShapeLayer的关系
 1，CAShapeLayer中shape代表形状的意思，所以需要形状才能生效
 2，贝塞尔曲线可以创建基于矢量的路径
 3，贝塞尔曲线给CAShapeLayer提供路径，CAShapeLayer在提供的路径中进行渲染。路径会闭环，所以绘制出了Shape
 4，用于CAShapeLayer的贝塞尔曲线作为Path，其path是一个首尾相接的闭环的曲线，即使该贝塞尔曲线不是一个闭环的曲线
 */

#import "BazierPathView.h"

@implementation BazierPathView

/**
 使用贝赛尔绘图只能在view的DrawRect中绘制，但如果结合了CAShapeLayer使用，那么可以不再view中使用
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //使用贝赛尔绘制绘制三角形(如果使用了CAShapeLayer那么直接在CAShapeLayer的属性设置颜色即可)
        //        UIColor *color = [UIColor redColor];
        //        //设置线条颜色
        //        [color set];
        // 2. 创建 UIBezierPath 对象
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(200, 200)];
        [path addLineToPoint:CGPointMake(150, 350)];
        [path addLineToPoint:CGPointMake(100, 200)];
        [path addLineToPoint:CGPointMake(80, 400)];
        [path addLineToPoint:CGPointMake(60, 200)];
        [path addLineToPoint:CGPointMake(20, 500)];
        //    [path applyTransform:CGAffineTransformMakeRotation(M_PI_4 / 2)];
        //设置路径闭合
        [path closePath];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame         = self.bounds;                // 与self的frame一致
        layer.strokeColor   = [UIColor redColor].CGColor;   // 边缘线的颜色
        layer.fillColor     = [UIColor clearColor].CGColor;   // 闭环填充的颜色
        layer.lineCap       = kCALineCapSquare;               // 边缘线的类型
        layer.path          = path.CGPath;                    // 从贝塞尔曲线获取到形状
        //    layer.lineWidth     = 1.0f;// 线条宽度
        //设置开始显示的path的百分比
        layer.strokeStart   = 0.0f;
        //设置结束显示path的百分比
        layer.strokeEnd     = 1.0f;
        // 将layer添加进图层
        [self.layer addSublayer:layer];
        
        // 给这个layer添加动画效果
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 2.0;
        //从path的指定百分比开始
        pathAnimation.fromValue = [NSNumber numberWithFloat:layer.strokeStart];
        //到path的指定百分比
        pathAnimation.toValue = [NSNumber numberWithFloat:layer.strokeEnd];
        [layer addAnimation:pathAnimation forKey:nil];
        
        //系统的方法，快速创建圆形
        UIBezierPath* aPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 400, 100, 100)];
        CAShapeLayer *layer1 = [CAShapeLayer layer];
        layer1.frame         = self.bounds;                // 与self的frame一致
        layer1.strokeColor   = [UIColor redColor].CGColor;   // 边缘线的颜色
        layer1.fillColor     = [UIColor clearColor].CGColor;   // 闭环填充的颜色
        layer1.lineCap       = kCALineCapSquare;               // 边缘线的类型
        layer1.path          = aPath.CGPath;                    // 从贝塞尔曲线获取到形状
        //    layer.lineWidth     = 1.0f;// 线条宽度
        //设置开始显示的path的百分比
        layer1.strokeStart   = 0.0f;
        //设置结束显示path的百分比
        layer1.strokeEnd     = 1.0f;
        // 将layer添加进图层
        [self.layer addSublayer:layer1];
        
        // 给这个layer添加动画效果
        CABasicAnimation *pathAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation1.duration = 2.0;
        //从path的指定百分比开始
        pathAnimation1.fromValue = [NSNumber numberWithFloat:layer1.strokeStart];
        //到path的指定百分比
        pathAnimation1.toValue = [NSNumber numberWithFloat:layer1.strokeEnd];
        [layer1 addAnimation:pathAnimation1 forKey:nil];
    };
    return self;
}

//- (void)drawRect:(CGRect)rect {
//    //    CGContextRef ctr = UIGraphicsGetCurrentContext();
//    //
//    //    CGContextMoveToPoint(ctr, 10, 10);
//    //
//    //    CGContextAddLineToPoint(ctr, 100, 100);
//    //
//    //    CGContextAddLineToPoint(ctr, 100, 200);
//    //
//    //    CGContextAddLineToPoint(ctr, 10, 10);
//    //
//    //    CGContextSetRGBStrokeColor(ctr,0,1.0,0,1.0);
//    //
//    //    CGContextSetLineWidth(ctr, 2);
//    //
//    //    CGContextStrokePath(ctr);
//    //使用贝赛尔绘制绘制三角形
//    UIColor *color = [UIColor redColor];
//    //设置线条颜色
//    [color set];
//    // 2. 创建 UIBezierPath 对象
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(200, 200)];
//    [path addLineToPoint:CGPointMake(150, 350)];
//    [path addLineToPoint:CGPointMake(100, 200)];
//    [path addLineToPoint:CGPointMake(80, 400)];
//    [path addLineToPoint:CGPointMake(60, 200)];
//    [path addLineToPoint:CGPointMake(20, 500)];
//    //    [path applyTransform:CGAffineTransformMakeRotation(M_PI_4 / 2)];
//    [path closePath];
//    //如果不使用CAShapeLayer需要设置路径渲染
//    [path stroke];
//    [path fill];
//}

@end
