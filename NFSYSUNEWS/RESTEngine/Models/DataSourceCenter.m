//
//  DataSourceCenter.m
//  NFSYSUNEWS
//
//  Created by yzq on 13-6-12.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import "DataSourceCenter.h"

@implementation DataSourceCenter
-(id) init{
    self=[super init];
    if (self) {
        NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"NfNewsModel" ofType:@"momd"];
        NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        NSURL *storeURL = nil;
        NSError *error = nil;
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
        storeURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        storeURL = [storeURL URLByAppendingPathComponent:@"NfNewsModel.sqlite"];
        
        NSLog(@"url是：%@",storeURL);
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:storeURL
                                                        options:nil
                                                          error:&error];
        
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:_persistentStoreCoordinator];
        [_managedObjectContext setMergePolicy:NSOverwriteMergePolicy];
        
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

-(NSMutableArray *) CollegeItemsArray{
    //发起请求(id初始值0)  请求id>0的值
    //有则插入
    //从数据库请求
    //返回
    //NSMutableArray *newsItemsArray=[[NSMutableArray alloc] initWithCapacity:0];
    self.dataSource=nil;
    [AppDelegateShare.engine fetchIndexNewsItemsOnSucceeded:^(NSMutableArray *listOfModelBaseObjects){
        self.dataSource =listOfModelBaseObjects;               //首页列表源
    } onError:^(NSError *engineError) {
        [UIAlertView showWithError:engineError];
    }];
    if (_dataSource) {
        NSEntityDescription* description = [NSEntityDescription entityForName: @"CollegeItemModel"
                                                       inManagedObjectContext:_managedObjectContext]; 
        //要插入的对象
//        NSMutableArray *collegeNewsItems=[NSMutableArray array];                                    
        [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {   //把json数组初始化对象，再存入
            CollegeItemModel *item=[[CollegeItemModel alloc] initWithEntity:description insertIntoManagedObjectContext:nil];
            [item setValuesForKeysWithDictionary:obj];
            [_managedObjectContext insertObject:item];
        }];

        NSError *error;
        if(![_managedObjectContext save:&error])
        {
            NSLog(@"不能保存：%@",[error localizedDescription]);
        }

        //！从coreData数据库请求数据
    }
    return _dataSource;
}

@end
