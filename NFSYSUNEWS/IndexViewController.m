//
//  IndexViewController.m
//  南苑新声
//
//  Created by yzq on 13-5-7.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

//#import "TableViewCellWithImage.h"
//#import "TableViewCellForNews.h"
//#import "DetailViewController.h"
//#import "FacultyItem.h"

#import "IndexViewController.h"
#import "TableViewCellWithImage.h"
#import "ImgViewController.h"
#import "CollegeItemModel.h"
#import "TableViewCellForNews.h"

#define SectionHeaderHeight 32
#define HeightForImgSwitch 160.0
#define HeightForImgCell 112.0
#define HeightForCellNews 147.0

@implementation IndexViewController

#pragma mark --lifeCycle--
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.viewDeckController openLeftViewAnimated:NO];    //运行程序前打开左侧视图
    screenShotArray =[[NSMutableArray alloc]init];
    [screenShotArray addObject:[self capture]];             //保持当前视图的截图
}
- (void)viewDidLoad{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"indexTableBg"]]];
    //[self.view setBackgroundColor:[UIColor greenColor]];
    
    [self setupNavgationBar];
    [self setupSlideViews]; //图片轮播
    
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, _navBar.frame.size.height, ViewBoundsSize.width, ViewBoundsSize.height-_navBar.frame.size.height-20)];
    [self setupDataSource];
    self.showTable=showIntroTableView;  //默认显示简介视图
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];   //没有下划线
    [_tableView setBackgroundColor:[UIColor clearColor]];  //设置表格背景，如有有必要
    [self.view addSubview:_tableView];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self.viewDeckController closeLeftViewAnimated:YES];
}
#pragma mark --UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int numberOfRows=0;
    if (section == 0) {
        numberOfRows=1;
    }else if(section == 1){
        numberOfRows= self.showTable==showIntroTableView? _IntroItemsArray.count : _newsItemsArray.count;
        numberOfRows+=8;
    }
    return numberOfRows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        //NSLog(@"加载完毕，且动画在运行着，且动画在运行着。停止动画"); 
    }
    
    //显示图片轮播
    if (indexPath.section==0) {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        [cell addSubview:self.imageFrame];
        return cell;
    }else if (self.showTable==showIntroTableView) {
        //院系简介的表格
        TableViewCellWithImage *cell=(TableViewCellWithImage *)[tableView dequeueReusableCellWithIdentifier:CellWithImageIdentifer];
        if (!cell) {
            cell = (TableViewCellWithImage *)[[[NSBundle mainBundle] loadNibNamed:@"TableViewCellWithImage" owner:self options:nil] lastObject];
            
            UIView *bgView=[[UIView alloc] initWithFrame:cell.frame];
            [bgView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"introCellBg"]]];
            [cell setBackgroundView:bgView];
            UIView *slBgView=[[UIView alloc] initWithFrame:cell.frame];
            [slBgView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"introCellBgSelect"]]];
            [cell setSelectedBackgroundView:slBgView];
        }
        //赋值
        //cell.cellTitle.text=item.itemTitle;
        //cell.cellTitle.text=@"哈哈哈";
        return cell;
    }
    else if (self.showTable==showNewsTableView){
        TableViewCellForNews *cell=(TableViewCellForNews *)[tableView dequeueReusableCellWithIdentifier:CellForNewsIdentifer];
        if (!cell) {
            cell = (TableViewCellForNews *)[[[NSBundle mainBundle] loadNibNamed:@"TableViewCellForNews" owner:self options:nil] lastObject];
//            UIView *bgView2=[[UIView alloc] initWithFrame:cell.frame];
//            [bgView2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"newsBg"]]];
//            [cell setBackgroundView:bgView2];
//            UIView *slBgView2=[[UIView alloc] initWithFrame:cell.frame];
//            [slBgView2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"newsBgSelect"]]];
//            [cell setSelectedBackgroundView:slBgView2];
            
        }
        if (_newsItemsArray) {
            CollegeItemModel *item=[_newsItemsArray objectAtIndex:indexPath.row];
            cell.newsTitle.text=[item valueForKey:@"itemTitle"];
            cell.newsDate.text=[item valueForKey:@"itemDate"];
            cell.newsAuthor.text=[item valueForKey:@"itemAuthor"];
            cell.newsSummary.text=[item valueForKey:@"itemDescription"];
            /*
             @property (nonatomic, retain) NSNumber * itemId;
             @property (nonatomic, retain) NSString * itemTitle;
             @property (nonatomic, retain) NSString * itemAuthor;
             @property (nonatomic, retain) NSString * itemDescription;
             @property (nonatomic, retain) NSString * itemDate;
             @property (nonatomic, retain) NSString * itemContent;
            */
        }
        return cell;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
#pragma mark --UITableViewDelegate--
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat heightForRow=0;
    if (indexPath.section==0) {
        heightForRow=HeightForImgSwitch;
    }
    else{
        heightForRow= self.showTable==showIntroTableView ? HeightForImgCell : HeightForCellNews;
    }
    return heightForRow;
}
//header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    int heightForHeader=0;
    if (section==1) {
        heightForHeader=SectionHeaderHeight;     //章节头部的高度
    }
    return heightForHeader;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{   //切换视图
    UIView *headerView=nil;
    if (section==1) {           //设置切换按钮
        UIButton *introBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, ViewBoundsSize.width/2,SectionHeaderHeight)];
        [introBtn setTitle:@"院系简介" forState:UIControlStateNormal];
        [introBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [introBtn addTarget:self action:@selector(viewTransition:) forControlEvents:UIControlEventTouchUpInside];
        introBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        introBtn.tag=introTableBtn;    //标示tag，用于切换背景
//        [introBtn setBackgroundImage:[UIImage imageNamed:@"indexSectionBtn"] forState:UIControlStateNormal];
//        introBtn.selected=YES;
        [introBtn setBackgroundImage:[UIImage imageNamed:@"indexSectionBtn"] forState:UIControlStateSelected];
        
        UIButton *newsBtn=[[UIButton alloc] initWithFrame:CGRectMake(ViewBoundsSize.width/2, 0, ViewBoundsSize.width/2, SectionHeaderHeight)];
        [newsBtn setTitle:@"学院动态" forState:UIControlStateNormal];
        [newsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [newsBtn addTarget:self action:@selector(viewTransition:) forControlEvents:UIControlEventTouchUpInside];
        newsBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        newsBtn.tag=newsTableBtn;    //标示tag，用于切换背景
//        [newsBtn setBackgroundImage:[UIImage imageNamed:@"indexSectionBg"] forState:UIControlStateNormal];
        [newsBtn setBackgroundImage:[UIImage imageNamed:@"indexSectionBtn"] forState:UIControlStateSelected];
        
        headerView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewBoundsSize.width, SectionHeaderHeight)];
        [headerView addSubview:introBtn];
        [headerView addSubview:newsBtn];
        [headerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"indexSectionBg"]]];
    }
    return headerView;
}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailViewController=nil;
    if (self.showTable==showNewsTableView) {
        detailViewController=[[DetailViewController alloc] initWithDataSource:[_newsItemsArray objectAtIndex:indexPath.row]];
    }else{
        detailViewController=[[DetailViewController alloc] initWithDataSource:[_IntroItemsArray objectAtIndex:indexPath.row]];
    }
    detailViewController.screenShotsArray=screenShotArray;
    detailViewController.view.tag=ViewTagDetail;
    
    //把要显示的值传过去
//    if (self.showTable==showNewsTableView){
//        NSLog(@"传的值：%@",[_newsItemsArray objectAtIndex:indexPath.row]);
//        detailViewController.dataSourceObject=;
//    }
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    //取消选中状态
    //[self performSelector:@selector(unselectCurrentRow) withObject:nil afterDelay:1.0];
    //[tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark --SGFocusImageFrameDelegate- 图片点击事件-
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    ImgViewController *imglViewController=[[ImgViewController alloc] init];
    [self.navigationController pushViewController:imglViewController animated:YES];
}

#pragma mark --My function--
-(void) setupNavgationBar{
    //这里改宽度跟屏幕一样，然后文字居中
    UILabel *titleLabe=[[UILabel alloc] initWithFrame:CGRectMake(0, 12, _navBar.frame.size.width,_navBar.frame.size.height)];
    titleLabe.textColor=[UIColor blackColor];
    [titleLabe setBackgroundColor:[UIColor clearColor]];
    titleLabe.text=@"南苑新声";
    [titleLabe setTextAlignment:NSTextAlignmentCenter];
    //标题，这里用items数组添加
    UINavigationItem *item = [[UINavigationItem alloc] init];
    item.titleView=titleLabe;
    //item.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];          //注意这里的target是self.viewDeckController
    NSArray *items = [[NSArray alloc]initWithObjects:item,nil];
    [_navBar setItems:items];
    //左按钮，这里直接加到view上
    UIButton *leftBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 56, 42)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"alpha"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"LeftNavBtnSelect"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    //右按钮，
    UIButton *rightBtn=[[UIButton alloc] initWithFrame:CGRectMake(ViewBoundsSize.width-50, 0, 50, 43)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"alpha"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"RightNavBtnSelect"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self.viewDeckController action:@selector(toggleRightView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];

}

-(void) setupDataSource{
    [AppDelegateShare.engine fetchIndexNewsItemsOnSucceeded:^(NSMutableArray *listOfModelBaseObjects){
        self.newsItemsArray =listOfModelBaseObjects;               //首页列表源
        [self.tableView reloadData];
    } onError:^(NSError *engineError) {
        [UIAlertView showWithError:engineError];
    }];
}
- (void)setupSlideViews{
    SGFocusImageItem *item1 = [[SGFocusImageItem alloc] initWithTitle:@"教学楼" image:[UIImage imageNamed:@"banner1"] tag:0] ;
    SGFocusImageItem *item2 = [[SGFocusImageItem alloc] initWithTitle:@"游泳池" image:[UIImage imageNamed:@"banner2"] tag:1] ;
    SGFocusImageItem *item3 = [[SGFocusImageItem alloc] initWithTitle:@"西区鸟瞰" image:[UIImage imageNamed:@"banner3"] tag:2] ;
    SGFocusImageItem *item4 = [[SGFocusImageItem alloc] initWithTitle:@"操场" image:[UIImage imageNamed:@"banner4"] tag:4] ;
    //图片轮播的大小位置
    self.imageFrame = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, HeightForImgSwitch)
                                                                    delegate:self
                                                             focusImageItems:item1, item2, item3, item4, nil];
    self.imageFrame.delegate=self;
}

//截取当前屏幕
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
-(void) viewTransition:(UIButton *) sender{
    //UIButton *otherBtn=nil;
    
    if (sender.tag==introTableBtn) {
        self.showTable=showIntroTableView;
        //otherBtn=(UIButton *)[sender.superview viewWithTag:newsTableBtn];
    }else if (sender.tag==newsTableBtn) {
        [self setShowTable:showNewsTableView];
        //otherBtn=(UIButton *)[sender.superview viewWithTag:introTableBtn];
    }

//    otherBtn.selected=NO;

    //这里需要修改成 reload section
    [_tableView reloadData];
}

@end

