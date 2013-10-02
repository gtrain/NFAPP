//
//  RESTfulEngine.m
//  iHotelApp
//
//  Created by Mugunth on 25/05/11.
//  Copyright 2011 Steinlogic. All rights reserved.

#import "RESTfulEngine.h"
#import "FacultyItem.h"
#import "CollegeItemModel.h"

@implementation RESTfulEngine

- (id) initWithHostName:(NSString*) hostName {
  self = [super initWithHostName:hostName];
  if (self) {
    [self registerOperationSubclass:[RESTfulOperation class]];
  }
  return self;
}

-(NSString*) accessToken
{
    if(!_accessToken)
    {
        _accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:kAccessTokenDefaultsKey];
    }
    
    return _accessToken;
}
-(void) setAccessToken:(NSString *) aAccessToken
{
    _accessToken = aAccessToken;
    
    // if you are going to have multiple accounts support, 
    // it's advisable to store the access token as a serialized object    
    // this code will break when a second RESTfulEngine object is instantiated and a new token is issued for him

    [[NSUserDefaults standardUserDefaults] setObject:self.accessToken forKey:kAccessTokenDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) prepareHeaders:(MKNetworkOperation *)operation {

  // this inserts a header like ''Authorization = Token blahblah''
  if(self.accessToken)
    [operation setAuthorizationHeaderValue:self.accessToken forAuthType:@"Token"];
  
  [super prepareHeaders:operation];
}

#pragma mark -
#pragma mark Custom Methods

// Add your custom methods here
-(RESTfulOperation*) loginWithName:(NSString*) loginName 
           password:(NSString*) password
        onSucceeded:(VoidBlock) succeededBlock 
            onError:(ErrorBlock) errorBlock
{  
  RESTfulOperation *op = (RESTfulOperation*) [self operationWithPath:LOGIN_URL];
  
  [op setUsername:loginName password:password basicAuth:YES];
  [op onCompletion:^(MKNetworkOperation *completedOperation) {
      
    NSDictionary *responseDict = [completedOperation responseJSON];	
    self.accessToken = [responseDict objectForKey:@"accessToken"];	
    succeededBlock();
  } onError:^(NSError *error) {
    
    self.accessToken = nil;
    errorBlock(error);

  }];
	
	[self enqueueOperation:op];  
  return op;
}


//获取首页的院系简介，应该在这里判断缓存对吧？
-(RESTfulOperation *) fetchFacultyItemsOnSucceeded:(ArrayBlock)succeededBlock onError:(ErrorBlock)errorBlock{
    RESTfulOperation *op=(RESTfulOperation*)[self operationWithPath:FacultyItemsKey];           //MKNetWokr的方法,跟baseurl合成
    [op onCompletion:^(MKNetworkOperation *completedOperation){
        if ([completedOperation responseJSON]) {
            NSMutableDictionary *responseDictionary=[completedOperation responseJSON];              //获取回应的json到字典
            
            NSMutableArray *facultyItemsJsonArr=[responseDictionary objectForKey:FacultyItemsKey];  //根据key提取json数组
            NSMutableArray *facultyItems=[NSMutableArray array];                                    //把json数组转换为用户定义的Model数组
            [facultyItemsJsonArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [facultyItems addObject:[[FacultyItem alloc] initWithDictionary:obj]];
            }];
            succeededBlock(facultyItems);                                                           //把获取到的数据作为参数保存到用户传入的block中
        }
                                                         
    } onError:errorBlock];
    [self enqueueOperation:op];  
    return nil;
}

//获取最新消息的数据源
-(RESTfulOperation *) fetchIndexNewsItemsOnSucceeded:(ArrayBlock)succeededBlock onError:(ErrorBlock)errorBlock{
    RESTfulOperation *op=(RESTfulOperation*)[self operationWithPath:CollegeNewsItemsKey];           //MKNetWokr的方法,跟baseurl合成
    [op onCompletion:^(MKNetworkOperation *completedOperation){
        if ([completedOperation responseJSON]) {
            NSMutableDictionary *responseDictionary=[completedOperation responseJSON];              //获取回应的json到字典
            NSMutableArray *collegeNewsItemsJsonArr=[responseDictionary objectForKey:CollegeNewsItemsKey];  //根据key提取json数组
            
//            NSMutableArray *collegeNewsItems=[NSMutableArray array];                                    //把json数组转换为用户定义的Model数组
//            [collegeNewsItemsJsonArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            [collegeNewsItems addObject:[[CollegeItemModel alloc] initWithDictionary:obj]];
//            }];
            succeededBlock(collegeNewsItemsJsonArr);                                                   //把获取到的数据作为参数保存到用户传入的block中
        }
    } onError:errorBlock];
    [self enqueueOperation:op];
    return nil;
}


-(RESTfulOperation*) fetchMenuItemsFromWrongLocationOnSucceeded:(ArrayBlock) succeededBlock 
                                                        onError:(ErrorBlock) errorBlock
{
  RESTfulOperation *op = (RESTfulOperation*) [self operationWithPath:@"404"];
  
  [op onCompletion:^(MKNetworkOperation *completedOperation) {
    
    NSMutableArray *responseArray = [completedOperation responseJSON];	
    NSMutableArray *menuItems = [NSMutableArray array];
    
    [responseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      
      [menuItems addObject:[[FacultyItem alloc] initWithDictionary:obj]];
    }];
    
    succeededBlock(menuItems);
    
  } onError:errorBlock];
	
	[self enqueueOperation:op];    
  return op;
}
@end
