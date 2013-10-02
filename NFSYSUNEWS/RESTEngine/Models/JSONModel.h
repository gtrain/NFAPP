//
//  ModelBase.h
//  Steinlogic
//
//  Created by Mugunth Kumar on 26-Jul-10.
//  Copyright 2011 Steinlogic All rights reserved.
//

#import <Foundation/Foundation.h>
//这里继承两类协议，用于本地化跟  处理深复制
@interface JSONModel : NSObject <NSCoding, NSCopying, NSMutableCopying> {

}

-(id) initWithDictionary:(NSMutableDictionary*) jsonObject;

@end
