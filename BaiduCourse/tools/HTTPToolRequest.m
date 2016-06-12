//
//  HTTPToolRequest.m
//  BaiduCourse
//
//  Created by apple on 7/6/16.
//  Copyright © 2016年 mark. All rights reserved.
//

#import "HTTPToolRequest.h"
#define TIMEOUTInterval 10


@implementation HTTPToolRequest


+ (AFHTTPSessionManager *)generalManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = TIMEOUTInterval;

    //header设置
     //通用设置
    /**
     
     [manager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
     
     */
    /** 设置接收数据的类型*/
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json", nil];

    return manager;
}


+ (void)GETURLString:(NSString *)urlString parameters:(NSDictionary *)paramaters progressBlock:(void(^)(NSProgress * downloadProgress))downloadProgressBlock sucessBlock:(void(^)(id responseObject))sucessBlock failureBlock:(void(^)(NSString *error))failureBlock
{
    AFHTTPSessionManager *manager = [self generalManager];
   
    [manager GET:urlString parameters:paramaters progress:^(NSProgress * _Nonnull downloadProgress){
        
        downloadProgressBlock(downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        sucessBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
    
}

+ (void)GETURLString:(NSString *)urlString parameters:(NSDictionary *)paramaters sucessBlock:(void(^)(id responseObject))sucessBlock failureBlock:(void(^)(NSString *error))failureBlock
{
    AFHTTPSessionManager *manager = [self generalManager];
    [manager GET:urlString parameters:paramaters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         sucessBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
  

}


@end
