//
//  HttpTool.h
//
//
//  Created by Apple on 14-7-12.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SuccessBlock)(id  JSON);
typedef void(^FailureBlock)(NSError *error);

@interface HttpTool : NSObject

//异步请求不能有返回值
+(void)postWithBaseURL:(NSString *)baseURL  path:(NSString *)path  params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)postWithBaseURL:(NSString *)baseURL path:(NSString *)path paramsArrray:(NSArray *)params success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)getWithBaseURL:(NSString *)baseURL  path:(NSString *)path  params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)downloadImage:(NSString *)url place:(UIImage *)placeImage imageView:(UIImageView *)imageView;

@end
