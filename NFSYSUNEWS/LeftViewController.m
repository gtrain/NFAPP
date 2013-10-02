//
//  LeftViewController.m
//  @南苑新声
//
//  Created by yzq on 13-5-7.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import "LeftViewController.h"
#import "ColumnViewController.h"
#import "IndexViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

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
    self.view.layer.cornerRadius = 4.0;
    self.view.layer.masksToBounds = YES;
    
    [_leftTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _leftTableView.clipsToBounds = YES; 
    [_leftTableView setBackgroundColor:[UIColor colorWithWhite:.28 alpha:1]];
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    self.leftTableViewDataSource=[NSMutableArray arrayWithArray:@[@"招生信息",@"常见问题"]];
    _leftTableView.delegate=self;
    _leftTableView.dataSource=self;
}

- (void)viewDidAppear:(BOOL)animated{
    [self.leftTableView selectRowAtIndexPath:self.selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [super viewDidAppear:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [self.leftTableView deselectRowAtIndexPath:[self.leftTableView indexPathForSelectedRow] animated:NO];
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --UITableViewDataSource--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return [_leftTableViewDataSource count];
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"sideCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //设置文字
        //cell.textLabel.highlightedTextColor
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:17.0]];
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        //设置选中背景
        //[cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        [cell.selectedBackgroundView setBackgroundColor:[UIColor colorWithWhite:.1 alpha:.7]];
        
        [cell.contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"sideCell"]]];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"主页";
    }else if (indexPath.section == 1) {
        cell.textLabel.text=[_leftTableViewDataSource objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark --TableViewDelegate--

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"当前选择的行%d",indexPath.row);
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        if ([controller.centerController isKindOfClass:[UINavigationController class]]) {
            UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:[self subConWithSection:indexPath.section Index:indexPath.row]];
            navController.navigationBarHidden=YES;
            self.viewDeckController.centerController = navController;
        }
        [NSThread sleepForTimeInterval:(300+arc4random()%700)/1000000.0]; // mimic delay... not really necessary
    }];
    self.selectedIndexPath = indexPath;
}

//这里根据选择的行数,让代理显示相应的视图
-(UIViewController *)subConWithSection:(int)section Index:(int)index
{
    UIViewController *subCon=nil;
    if (section==0 && index==0) {
        subCon=[[IndexViewController alloc]initWithNibName:@"IndexViewController" bundle:nil];
    }
    else{
        //把行数传进去，根据行数选择数据源
        subCon=[[ColumnViewController alloc]initWithNibName:@"ColumnViewController" bundle:nil];
    }
    return  subCon;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.sectionHeaderLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 25)];
    [_sectionHeaderLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"sideSection"]]];
    return self.sectionHeaderLabel;
}


@end
