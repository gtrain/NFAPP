//
//  FacultyItem.m
//  NFSYSUNEWS
//
//  Created by yang on 13-5-16.
//  Copyright (c) 2013年 yzq. All rights reserved.
//

#import "FacultyItem.h"

@implementation FacultyItem

//KVC 的健值赋值方法
/*
-(void) setValue:(id)value forKey:(NSString *)key
{
    //赋子类自己特有的值，即不是那些可以直接赋值的，直接赋值的KVC会自行赋值
//    这个类似微博里面的转发微博，你应该想把它映射到一个模型数组，而不是单单保存成数组属性
//    另外还应该再init函数中初始化数组对象
//     
//    if([key isEqualToString:@"reviews"])
//    {
//        for(NSMutableDictionary *reviewArrayDict in value)
//        {
//            Review *thisReview = [[Review alloc] initWithDictionary:reviewArrayDict];
//            [self.reviews addObject:thisReview];
//        }
//    }
 
    if([key isEqualToString:@"itemId"])
        self.itemId = value;
    else if([key isEqualToString:@"itemTitle"])
        self.itemTitle = value;
    else if([key isEqualToString:@"itemThumbLink"])
        self.itemThumbLink = value;
    else if([key isEqualToString:@"itemDescription"])
        self.itemDescription = value;
    else
        [super setValue:value forKey:key];
}*/
//赋值不同于json对应值的 property, 比如数据是id ，属性是itemId
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    if([key isEqualToString:@"id"])
//        self.itemId = value;
//    else if([key isEqualToString:@"description"])
//        self.itemDescription = value;
//    else
        [super setValue:value forUndefinedKey:key];
}





#pragma mark --NSCoding-- 
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.itemId forKey:@"itemId"];
    [encoder encodeObject:self.itemTitle forKey:@"itemTitle"];
    [encoder encodeObject:self.itemThumbLink forKey:@"itemThumbLink"];
    [encoder encodeObject:self.itemDescription forKey:@"itemDescription"];
}
- (id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self) {
        self.itemId = [decoder decodeObjectForKey:@"itemId"];
        self.itemTitle = [decoder decodeObjectForKey:@"itemTitle"];
        self.itemThumbLink = [decoder decodeObjectForKey:@"itemThumbLink"];
        self.itemDescription = [decoder decodeObjectForKey:@"itemDescription"];
    }
    return self;
}

#pragma mark --NSCoding 子类的深复制(option)-- 
- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
    
    [theCopy setItemId:[self.itemId copy]];
    [theCopy setItemTitle:[self.itemTitle copy]];
    [theCopy setItemThumbLink:[self.itemThumbLink copy]];
    [theCopy setItemDescription:[self.itemDescription copy]];
    
    return theCopy;
}


@end
