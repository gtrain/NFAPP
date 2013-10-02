//
//  DetailViewController.m
//  南苑新声
//
//  Created by yzq on 13-5-3.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import "DetailViewController.h"
#import "IIViewDeckController.h"

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

@interface DetailViewController (){
    UIView *blackMask;
    UIImageView *lastScreenShotView;
    
    CGPoint startTouchPoint;
    BOOL isBackMoving;
    BOOL isMoving;
}
@property (nonatomic,retain) UIView *backgroundView;
@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.screenShotsArray = [[NSMutableArray alloc]init];   //截图数组
    }
    return self;
}

-(id) initWithDataSource:(id)dataSource{
    self=[super init];
    if (self) {
        self.dataSourceObject=dataSource;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化导航栏
    self.navView=(NavBarForDetail *)[[[NSBundle mainBundle] loadNibNamed:@"NavBarForDetail" owner:self options:nil] lastObject];
    [_navView.backBtn addTarget:self action:@selector(backBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    //初始化webView
    self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(1, _navView.frame.size.height, 318, ViewBoundsSize.height-_navView.frame.size.height)];
    
    if (_dataSourceObject) {
        CollegeItemModel *item=_dataSourceObject;
        _navView.newsTitle.text=[item valueForKey:@"itemTitle"];
        [_webView loadHTMLString:[item valueForKey:@"itemContent"] baseURL:nil];
    }
    
    _navView.tag=ViewTagDetail;     //view标记，用于取消滑动打开侧边
    
    [_webView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_webView];    
    [self.view addSubview:_navView];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.screenShotsArray removeLastObject];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)backBtnPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"shouldReceiveTouch");
    return NO;
}

#pragma mark --点击事件--

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
    if(self.navigationController.viewControllers.count <= 1) return;
    
    isMoving = NO;
    isBackMoving = NO;
    startTouchPoint = [((UITouch *)[touches anyObject])locationInView:KEY_WINDOW];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{

    [super touchesCancelled:touches withEvent:event];
    if (self.navigationController.viewControllers.count <= 1) return;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self moveViewWithX:0];
    } completion:^(BOOL finished) {
        isMoving = NO;
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    CGPoint endTouch = [((UITouch *)[touches anyObject])locationInView:KEY_WINDOW];
    
    if (endTouch.x - startTouchPoint.x >50)
    {
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:320.0f];
        }completion:^(BOOL finished) {
            [self.navigationController popViewControllerAnimated:NO];
            CGRect frame = self.view.frame;
            frame.origin.x = 0;
            self.view.frame = frame;
            isMoving = NO;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            isMoving =NO;
        }];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    CGPoint moveTouch = [((UITouch *)[touches anyObject])locationInView:KEY_WINDOW];
    if (!isMoving)
    {
        if (moveTouch.x - startTouchPoint.x > 10)
        {
            isMoving = YES;
            if (!self.backgroundView)
            {
                CGRect frame = self.view.frame;
                
                self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
                [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
                blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
                blackMask.backgroundColor = [UIColor blackColor];
                [self.backgroundView addSubview:blackMask];
            }
            if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
            
            UIImage *lastScreenShot = [self.screenShotsArray lastObject];
            lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
            [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
            
        }
        
    }

    if (isMoving) {
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:moveTouch.x - startTouchPoint.x];
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)moveViewWithX:(CGFloat)x
{
    x = x>320?320:x;
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float scale = (x/6400)+0.95;
    float alpha = 0.4 - (x/800);
    
    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
}

@end
