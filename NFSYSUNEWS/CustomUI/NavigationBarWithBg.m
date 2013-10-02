//
//  NavigationBarWithBg.m
//  南苑新声
//
//  Created by yzq on 13-5-3.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import "NavigationBarWithBg.h"
#import <QuartzCore/QuartzCore.h>

@implementation NavigationBarWithBg

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(id)init{
    self=[super init];
    if (self) {
        
        
        if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
            [self setBackgroundImage:[UIImage imageNamed:@"NavBarBg"] forBarMetrics:UIBarMetricsDefault];
        } else {
            [self drawRect:self.bounds];
        }
        
        CGRect bounds = self.bounds;
        bounds.size.height +=10;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                       byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                             cornerRadii:CGSizeMake(10.0, 10.0)];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = bounds;
        maskLayer.path = maskPath.CGPath;
        [self.layer addSublayer:maskLayer];
        self.layer.mask = maskLayer;
        self.layer.shadowOffset = CGSizeMake(3, 3);
        self.layer.shadowOpacity = 0.7;
        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        
        //        self.layer.shadowColor = [UIColor blackColor].CGColor;
        //        self.layer.shadowOffset = CGSizeMake(0, 0);
        //        self.layer.shadowOpacity = 0.6;
        //        self.layer.shadowRadius = 3.0;
        //        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 320.0, 44.0)].CGPath;
        //        self.layer.masksToBounds = YES;
        //        self.opaque = NO;
        //        self.backgroundColor = [UIColor clearColor];
        //        self.layer.backgroundColor = [UIColor clearColor].CGColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"NavBarBg"] drawInRect:rect];
}

@end
