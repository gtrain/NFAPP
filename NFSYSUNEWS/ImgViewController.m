//
//  ImgViewController.m
//  NFSYSUNEWS
//
//  Created by yzq on 13-6-6.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import "ImgViewController.h"
#import "ImgCell.h"

@implementation ImgViewController

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

    UIButton *leftBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 56, 42)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"NormalBackBtn"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    //标题
    UILabel *titleLabe=[[UILabel alloc] initWithFrame:CGRectMake(0, 12, _navView.frame.size.width-2,_navView.frame.size.height)];
    titleLabe.textColor=[UIColor blackColor];
    [titleLabe setBackgroundColor:[UIColor clearColor]];
    titleLabe.text=@"学院新声";
    [titleLabe setTextAlignment:NSTextAlignmentCenter];
    
    //标题，这里用items数组添加
    UINavigationItem *item = [[UINavigationItem alloc] init];
    item.titleView=titleLabe;
    //item.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];          //注意这里的target是self.viewDeckController
    NSArray *items = [[NSArray alloc]initWithObjects:item,nil];
    [_navView setItems:items];
    
    self.imgTable=[[UITableView alloc] initWithFrame:CGRectMake(1, _navView.frame.size.height, 318, ViewBoundsSize.height-_navView.frame.size.height)];
    _imgTable.rowHeight=180;
    _imgTable.delegate=self;
    _imgTable.dataSource=self;
    [self.view addSubview:_imgTable];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)backBtnPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImgCell *cell=(ImgCell *)[tableView dequeueReusableCellWithIdentifier:ImgCellIdentifer];
    if (!cell) {
        cell = (ImgCell *)[[[NSBundle mainBundle] loadNibNamed:@"ImgCell" owner:self options:nil] lastObject];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    //赋值
    return cell;

}

@end
