//
//  UIButton+RedPoint.m
//  DZ
//
//  Created by Nonato on 14-7-7.
//
//

#import "UIButton+RedPoint.h"

@implementation UIButton_RedPoint

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.showpoint = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.selected == YES) {
        self.showpoint = NO;
        return;
    }
    if (self.showpoint) {
        [self drawCircleWithCenter:CGPointMake(CGRectGetMaxX(rect)-10,CGRectGetMinY(rect) + 10)
                            radius:POINTWIDTH];
    }

}

//圆形
-(void)drawCircleWithCenter:(CGPoint)center
                     radius:(float)radius
{
    CGContextRef     context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGPathAddArc(pathRef,
                 &CGAffineTransformIdentity,
                 center.x,
                 center.y,
                 radius,
                 -M_PI/2,
                 radius*2*M_PI-M_PI/2,
                 NO);
    CGPathCloseSubpath(pathRef);
    
    CGContextAddPath(context, pathRef);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillPath(context);
    //    CGContextDrawPath(context,kCGPathFillStroke); //画空心圆 并且去掉前面两行
    CGPathRelease(pathRef);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
