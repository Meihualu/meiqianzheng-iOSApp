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

//- (void)inithttps{
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//    securityPolicy.allowInvalidCertificates = YES;
//    [AFHTTPRequestOperationManager manager].securityPolicy = securityPolicy;
//}

+(void)requestWithBaseURL:(NSString *)baseURL path:(NSString *)path params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure  methed:(NSString *)method{
    
    AFHTTPClient * client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:baseURL]];
    
//    NSMutableDictionary * allParams = [NSMutableDictionary dictionary];
//    [allParams setDictionary:params];
//    [allParams setObject:[AccountTool sharedAccountTool].account.accessToken forKey:@"access_token"];
    
    NSURLRequest * post = [client requestWithMethod:method path:path  parameters:params];
    
    /*
     NSMutableURLRequest * post = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/access_token"]];
     post.HTTPMethod = @"POST";
     NSString *param = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@",kAppKey,kAppSecret,requestToken,kRedictURI];
     post.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
     */
    
    
    //创建AFJSONRequestOperation对象
    NSOperation * op = [AFJSONRequestOperation JSONRequestOperationWithRequest:post success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (success == nil) {
            return ;
        }
//        NSLog(@"json = %@",JSON);
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"+++++++error.localizedDescription = %@",error.localizedDescription);
        NSLog(@"statusCode = %zd\n",response.statusCode);
        failure(JSON);
    }];
    
    [op start];
}

+(void)requestWithBaseURL:(NSString *)baseURL path:(NSString *)path paramsArray:(NSArray *)params success:(SuccessBlock)success failure:(FailureBlock)failure  methed:(NSString *)method{
    
     NSMutableURLRequest * post = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseURL]];
     post.HTTPMethod = @"POST";
    NSLog(@"params = %@\n",params);
    post.HTTPBody = [NSKeyedArchiver archivedDataWithRootObject:params];
    
    //创建AFJSONRequestOperation对象
    NSOperation * op = [AFJSONRequestOperation JSONRequestOperationWithRequest:post success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (success == nil) {
            return ;
        }
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error.localizedDescription = %@",error.localizedDescription);
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

+(void)downloadImage:(NSString *)url place:(UIImage *)placeImage imageView:(UIImageView *)imageView{

//    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeImage options:SDWebImageLowPriority|SDWebImageRetryFailed];
}

+(void)postWithBaseURL:(NSString *)baseURL path:(NSString *)path paramsArrray:(NSArray *)params success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self requestWithBaseURL:baseURL path:path paramsArray:params success:success failure:failure methed:@"POST"];
}
@end
