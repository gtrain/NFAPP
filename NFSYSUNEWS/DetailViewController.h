//
//  DetailViewController.h
//  南苑新声
//
//  Created by yzq on 13-5-3.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NavBarForDetail.h"
#import "CollegeItemModel.h"

@interface DetailViewController : UIViewController<UIGestureRecognizerDelegate>
//滑动返回的截图数组
@property (nonatomic,retain) NSMutableArray *screenShotsArray;
//显示的数据源
@property (nonatomic,strong) id dataSourceObject;
//标题栏
@property (nonatomic,strong) NavBarForDetail *navView;
@property (nonatomic,strong) UIWebView *webView;

-(id) initWithDataSource:(id)dataSource;

@end
