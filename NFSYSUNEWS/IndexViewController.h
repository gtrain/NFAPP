//
//  IndexViewController.h
//  南苑新声
//
//  Created by yzq on 13-5-7.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "NavigationBarWithBg.h"
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"

typedef enum displayTable{
    showIntroTableView=0,
    showNewsTableView=1,
    introTableBtn,
    newsTableBtn,
}displayTable;

@interface IndexViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SGFocusImageFrameDelegate>{
    NSMutableArray *screenShotArray;    //保持当前视图的截图数组，用于滑动返回
}

@property (weak, nonatomic) IBOutlet NavigationBarWithBg *navBar;
@property (nonatomic,strong) SGFocusImageFrame *imageFrame; //图片轮播
@property (nonatomic,strong) UITableView *tableView;      //显示的信息列表
@property (nonatomic) displayTable showTable;             //设置显示的表格

@property (nonatomic,strong) NSMutableArray *newsItemsArray;
@property (nonatomic,strong) NSMutableArray *IntroItemsArray;
@end