//
//  AppDelegate.h
//  NFSYSUNEWS
//
//  Created by yzq on 13-5-15.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTfulEngine.h"
#import "AppDelegate.h"

#define AppDelegateShare ((AppDelegate *)[UIApplication sharedApplication].delegate)

typedef enum MyViewTag{
    ViewTagTouchClose=21,   //点击关闭侧边栏的临时view
    ViewTagDetail,          //非主视图
    ViewTagMain,            //主视图
}MyViewTag;

//方便调用

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *centerViewController;
@property (strong, nonatomic) UIViewController *leftController;

@property (nonatomic, strong) RESTfulEngine *engine;

@end
