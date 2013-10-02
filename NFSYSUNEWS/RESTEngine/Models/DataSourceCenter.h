//
//  DataSourceCenter.h
//  NFSYSUNEWS
//
//  Created by yzq on 13-6-12.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CollegeItemModel.h"

@interface DataSourceCenter : NSObject

@property(nonatomic, retain) NSManagedObjectModel* managedObjectModel;
@property(nonatomic, retain) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@property(nonatomic, retain) NSManagedObjectContext* managedObjectContext;
@property(nonatomic, retain) NSMutableArray* dataSource;

//获取学院动态的数据
-(NSMutableArray *) CollegeItemsArray;

@end
