//
//  RequestHandler.m
//  Music
//
//  Created by U on 2018/11/30.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "RequestHandler.h"

#import "Request.h"
#import "ResponseSerializer.h"

@interface RequestHandler ()

@property(strong, nonatomic, nonnull) AFHTTPSessionManager *httpSessionManager;

@end

@implementation RequestHandler

+ (RequestHandler *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _httpSessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:NULL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _httpSessionManager.responseSerializer = [ResponseSerializer serializer];
        [_httpSessionManager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
            return [[RequestHandler sharedInstance] queryStringSerialization:request parameters:parameters error:error];
        }];
    }
    return self;
}


/**
 配置查询字符串参数序列化: 自定义queryString转换

 @param request 请求体
 @param parameters 参数
 @param error 错误
 @return 转换后的参数
 */
- (NSString *)queryStringSerialization:(NSURLRequest *)request parameters:(id)parameters error:(NSError *__autoreleasing *)error {
    
    NSArray* (^parametersToArray)(NSDictionary *dictionary) = ^(NSDictionary *dictionary) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:dictionary.count];
        for (NSObject *key in dictionary.allKeys) {
            [array addObject:[NSString stringWithFormat:@"%@=%@", key, [dictionary objectForKey:key]]];
        }
        return [NSArray arrayWithArray:array];
    };
    
    NSString *(^parametersToString)(NSArray *array) = ^(NSArray *array) {
        return [array componentsJoinedByString:@"&"];
    };
    
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = parameters;
        if (dict.count == 0) {
            return NULL;
        }
        return parametersToString(parametersToArray(parameters));
    }
    else if ([parameters isKindOfClass:[NSArray class]]) {
        NSArray *array = parameters;
        if (array.count == 0) {
            return NULL;
        }
        return parametersToString(parameters);
    }
    else if ([parameters isKindOfClass:[NSString class]]) {
        return parameters;
    }
    else {
        return NULL;
    }
}

#pragma mark get / set

- (NetworkReachabilityStatus)networkReachabilityStatus {
    return (NetworkReachabilityStatus)[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval {
    _timeoutInterval = timeoutInterval;
    _httpSessionManager.requestSerializer.timeoutInterval = _timeoutInterval;
}

#pragma mark - 请求方法

- (NSURLSessionDataTask *)sendRequestWithURLString:(NSString *)URLString Method:(HTTPMethod)method parameters:(id)parameters delegate:(id<RequestHandlerDelegate>)delegate {
    if (method == HTTPMethodGet) {
        return [_httpSessionManager GET:URLString parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [delegate requestHandlerResponseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [delegate requestHandlerError:error];
        }];
    }
    else if (method == HTTPMethodPost) {
        return [_httpSessionManager POST:URLString parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [delegate requestHandlerResponseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [delegate requestHandlerError:error];
        }];
    }
    else {
        return NULL;
    }
}

@end
