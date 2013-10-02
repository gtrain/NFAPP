//
//  ColumnViewController.m
//  南苑新声
//
//  Created by yzq on 13-5-3.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import "ColumnViewController.h"

@interface ColumnViewController ()

@end

@implementation ColumnViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tag=ViewTagMain;  //标记用于滑动打开侧边
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
