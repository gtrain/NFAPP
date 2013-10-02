//
//  LeftViewController.h
//  @南苑新声
//
//  Created by yzq on 13-5-7.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UILabel *sectionHeaderLabel;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (strong,nonatomic) NSMutableArray *leftTableViewDataSource;
@property (nonatomic, retain) NSIndexPath * selectedIndexPath;              //记下选择的行数，初始化为section 0 row 0

@end
