//
//  TableViewCellForNews.h
//  NFSYSUNEWS
//
//  Created by yzq on 13-5-19.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CellForNewsIdentifer @"newsCell"

@interface TableViewCellForNews : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsSummary;
@property (weak, nonatomic) IBOutlet UILabel *newsAuthor;
@property (weak, nonatomic) IBOutlet UILabel *newsDate;

@end
