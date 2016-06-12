//
//  HTTPToolRequest.h
//  BaiduCourse
//
//  Created by apple on 7/6/16.
//  Copyright © 2016年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>

@interface HTTPToolRequest : NSObject


+ (void)GETURLString:(NSString *)urlString parameters:(NSDictionary *)paramaters progressBlock:(void(^)(NSProgress *  downloadProgress))downloadProgressBlock sucessBlock:(void(^)(id responseObject))sucessBlock failureBlock:(void(^)(NSString *error))failureBlock;

+ (void)GETURLString:(NSString *)urlString parameters:(NSDictionary *)paramaters sucessBlock:(void(^)(id responseObject))sucessBlock failureBlock:(void(^)(NSString *error))failureBlock;


@end
