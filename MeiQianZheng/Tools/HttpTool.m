//
//  HttpTool.m
//  新浪微博练习
//
//  Created by Apple on 14-7-12.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

@implementation HttpTool

+(void)requestWithBaseURL:(NSString *)baseURL path:(NSString *)path params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure  methed:(NSString *)method{
    
    AFHTTPClient * client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:baseURL]];
    NSURLRequest * post = [client requestWithMethod:method path:path  parameters:params];
    //创建AFJSONRequestOperation对象
    NSOperation * op = [AFJSONRequestOperation JSONRequestOperationWithRequest:post success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (success == nil) {
            return ;
        }
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        failure(JSON);
    }];
    
    [op start];
}

+(void)postWithBaseURL:(NSString *)baseURL path:(NSString *)path params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure{
    
    [self requestWithBaseURL:baseURL path:path params:params success:success failure:failure methed:@"POST"];
    
}

+(void)getWithBaseURL:(NSString *)baseURL path:(NSString *)path params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self requestWithBaseURL:baseURL path:path params:params success:success failure:failure methed:@"GET"];
}

@end
