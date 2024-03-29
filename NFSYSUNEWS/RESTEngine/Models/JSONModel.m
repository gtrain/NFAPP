//
//  ModelBase.m
//  Steinlogic
//
//  Created by Mugunth Kumar on 26-Jul-10.
//  Copyright 2011 Steinlogic All rights reserved.
//

#import "JSONModel.h"


@implementation JSONModel

-(id) initWithDictionary:(NSMutableDictionary*) jsonObject
{
    if((self = [super init]))
    {
        [self setValuesForKeysWithDictionary:jsonObject];       //自动匹配健值，如果没有则抛出undefine
    }
    return self;
}

-(BOOL) allowsKeyedCoding
{
	return YES;
}

- (id) initWithCoder:(NSCoder *)decoder
{	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
	// do nothing.
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
  // subclass implementation should do a deep mutable copy
  // this class doesn't have any ivars so this is ok
	JSONModel *newModel = [[JSONModel allocWithZone:zone] init];
	return newModel;
}

-(id) copyWithZone:(NSZone *)zone
{    
  // subclass implementation should do a deep mutable copy
  // this class doesn't have any ivars so this is ok
	JSONModel *newModel = [[JSONModel allocWithZone:zone] init];
	return newModel;
}

- (id)valueForUndefinedKey:(NSString *)key
{
    // subclass implementation should provide correct key value mappings for custom keys
    NSLog(@"warn!！valueForUndefinedKey Undefined Key: %@", key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // subclass implementation should set the correct key value mappings for custom keys
    NSLog(@"warn! forUndefinedKey Undefined Key: %@", key);
}



@end
