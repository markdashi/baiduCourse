//
//  NSObject+propertyCode.h
//  runtime
//
//  Created by apple on 1/6/16.
//  Copyright © 2016年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (propertyCode)

/**
 *  自动生成属性申明Code
 *
 *  @param dict 传入的字典
 */
+ (void)propertyCodeWithDictionary:(NSDictionary *)dict;



@end
