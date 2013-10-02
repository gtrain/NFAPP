//
//  FacultyItem.h
//  NFSYSUNEWS
//
//  Created by yang on 13-5-16.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import "JSONModel.h"
/*
 "id":"\",
 "title":"\",
 "thumbLink":"",
 "description" : "Teriyaki Bento is one of the best lorem ipsum dolor sit"
 */
@interface FacultyItem : JSONModel

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *itemThumbLink;
@property (nonatomic, strong) NSString *itemDescription;

@end
