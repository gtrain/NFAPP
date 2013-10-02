//
//  ImgViewController.h
//  NFSYSUNEWS
//
//  Created by yzq on 13-6-6.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NavBarForImgView.h"

@interface ImgViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic,strong) NavBarForImgView *navView;         //标题栏
@property (weak, nonatomic) IBOutlet UINavigationBar *navView;

@property (nonatomic,strong) UITableView *imgTable;             //图片表格
@property (nonatomic,strong) NSMutableArray *imgItemsArray;     //图片数据源

@end
