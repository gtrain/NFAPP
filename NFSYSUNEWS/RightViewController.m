//
//  RightViewController.m
//  @南苑新声
//
//  Created by yzq on 13-5-7.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

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
    [self.view setBackgroundColor:[UIColor colorWithWhite:.28 alpha:1]];
    
    UIButton *btn1=[[UIButton alloc] initWithFrame:CGRectMake(ViewBoundsSize.width/2.5+10, 20, 161, 45)];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"RightSideBtn"] forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"RightSideBtnSelect"] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"微博问答" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    UIButton *btn2=[[UIButton alloc] initWithFrame:CGRectMake(ViewBoundsSize.width/2.5+10, btn1.frame.size.height+32, 161, 45)];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"RightSideBtn"] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"RightSideBtnSelect"] forState:UIControlStateHighlighted];
    [btn2 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"应用信息" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
