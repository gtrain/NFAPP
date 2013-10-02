//
//  NavBarForImgView.m
//  NFSYSUNEWS
//
//  Created by yzq on 13-6-8.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import "NavBarForImgView.h"

@implementation NavBarForImgView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"NormalBarBg"] drawInRect:rect];
}


@end
