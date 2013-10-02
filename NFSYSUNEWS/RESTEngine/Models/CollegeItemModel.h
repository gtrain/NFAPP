//
//  CollegeItemModel.h
//  NFSYSUNEWS
//
//  Created by yzq on 13-6-12.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CollegeItemModel : NSManagedObject

@property (nonatomic, retain) NSNumber * itemId;
@property (nonatomic, retain) NSString * itemTitle;
@property (nonatomic, retain) NSString * itemAuthor;
@property (nonatomic, retain) NSString * itemDescription;
@property (nonatomic, retain) NSString * itemDate;
@property (nonatomic, retain) NSString * itemContent;

-(id) initWithDictionary:(NSMutableDictionary*) jsonObject;

@end
