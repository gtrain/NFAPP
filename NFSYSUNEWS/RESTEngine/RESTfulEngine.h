//
//  RESTfulEngine.h
//  iHotelApp
//
//  Created by Mugunth on 25/05/11.
//  Copyright 2011 Steinlogic. All rights reserved.

#import <Foundation/Foundation.h>
#import "RESTfulOperation.h"
#import "JSONModel.h"

//定义API节点
#define LOGIN_URL       @"loginGeneral"
#define MENU_ITEMS_URL  @"about"
#define FacultyItemsKey @"facultyItems"
#define CollegeNewsItemsKey @"CollegeNewsItems"

#define kAccessTokenDefaultsKey @"ACCESS_TOKEN"

typedef void (^VoidBlock)(void);
typedef void (^ModelBlock)(JSONModel* aModelBaseObject);
typedef void (^ArrayBlock)(NSMutableArray* listOfModelBaseObjects);
typedef void (^ErrorBlock)(NSError* engineError);

@interface RESTfulEngine : MKNetworkEngine {

    NSString *_accessToken;
}

@property (nonatomic) NSString *accessToken;

-(id) loginWithName:(NSString*) loginName 
           password:(NSString*) password                         
        onSucceeded:(VoidBlock) succeededBlock 
            onError:(ErrorBlock) errorBlock;

-(RESTfulOperation *) fetchFacultyItemsOnSucceeded:(ArrayBlock)succeededBlock
                                           onError:(ErrorBlock)errorBlock;
-(RESTfulOperation *) fetchIndexNewsItemsOnSucceeded:(ArrayBlock)succeededBlock
                                           onError:(ErrorBlock)errorBlock;

-(RESTfulOperation*) fetchMenuItemsFromWrongLocationOnSucceeded:(ArrayBlock) succeededBlock
                                                        onError:(ErrorBlock) errorBlock;
@end
