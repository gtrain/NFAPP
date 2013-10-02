//
//  CollegeItemModel.m
//  NFSYSUNEWS
//
//  Created by yzq on 13-6-12.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import "CollegeItemModel.h"


@implementation CollegeItemModel

@dynamic itemId;
@dynamic itemTitle;
@dynamic itemAuthor;
@dynamic itemDescription;
@dynamic itemDate;
@dynamic itemContent;

-(id) initWithDictionary:(NSMutableDictionary*) jsonObject
{
    if((self = [super init]) && jsonObject)
    {
        [self setValuesForKeysWithDictionary:jsonObject];
//        self.itemId=[NSNumber numberWithInt:[[jsonObject objectForKey:@"itemId"] intValue]];
//        self.itemTitle=[jsonObject objectForKey:@"itemTitle"];
//        self.itemAuthor=[jsonObject objectForKey:@"itemAuthor"];
//        self.itemDescription=[jsonObject objectForKey:@"itemDescription"];
//        self.itemDate=[jsonObject objectForKey:@"itemDate"];
//        self.itemContent=[jsonObject objectForKey:@"itemContent"];
    }
    return self;
}

@end
