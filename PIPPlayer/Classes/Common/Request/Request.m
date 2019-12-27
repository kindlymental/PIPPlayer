//
//  Request.m
//  Music
//
//  Created by U on 2018/11/30.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "Request.h"

#import "RequestHandler.h"
#import "RequestCache.h"

#import <CommonCrypto/CommonDigest.h>

NSString * MD5(NSString *str) {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

@interface Request ()

@property (strong, nonatomic) NSURLSessionTask *task;

@end

@implementation Request

#pragma mark - 初始化方法

+ (instancetype)request {
    return [[self alloc] init];
}

#pragma mark - getter setter

- (NSURLSessionTaskState)state {
    return _task.state;
}

#pragma mark - 操作方法

/** 开始请求 */
- (__kindof Request *)startWithCompletionBlock:(void (^)(__kindof Request *))completionBlock {
    _completionBlock = completionBlock;
    
    if (self.task && (self.state == NSURLSessionTaskStateRunning ||
                      self.state == NSURLSessionTaskStateSuspended)) {
        [self.task cancel];
    }
    
    _responseObject = NULL;
    _error = NULL;
    _task = NULL;
    
    if (!_mustFromNetwork && [self readCache]) {
        
        _completionBlock ? _completionBlock(self) : NULL;
        _completionBlock = NULL;
    }
    else {
        [self dynamicURLStringWithCallback:^(NSString *URLString, id parameters) {
            self->_task = [[RequestHandler sharedInstance] sendRequestWithURLString:URLString Method:self.method parameters:parameters delegate:self];
        }];
    }
    return self;
}

/** 暂停请求 */
- (void)pause {
    [self.task suspend];
}

/** 结束请求 */
- (void)stop {
    _completionBlock = NULL;
    [self.task cancel];
}

#pragma mark - RequestHandlerDelegate （请求回来的处理）

- (void)requestHandlerResponseObject:(id)responseObject {
    _responseObject = responseObject;
    
    // 进行缓存
    [self storeCache];
    
    _completionBlock ? _completionBlock(self) : NULL;
    _completionBlock = NULL;
}

- (void)requestHandlerError:(NSError *)error {
    _error = error;

    _completionBlock ? _completionBlock(self) : NULL;
    _completionBlock = NULL;
}


#pragma mark - Cache

- (NSString *)groupName {
    return MD5(self.urlString);
}

- (NSString *)identifier {
    if (self.parameters) {
        return MD5(self.parameters.description);
    } else {
        return self.groupName;
    }
}

- (void)storeCache {
    
    if (self.cacheTimeoutInterval <= 0 || !_responseObject || ![self willStoreCache]) {
        return;
    }
    [[RequestCache sharedInstance] storeCachedJSONObjectForRequest:self];
}

- (BOOL)readCache {
    
    if (self.cacheTimeoutInterval <= 0) {
        return NO;
    }
    BOOL isTimeout;
    id cachedJSONObject = [[RequestCache sharedInstance] cachedJSONObjectForRequest:self isTimeout:&isTimeout];
    if (cachedJSONObject && !isTimeout) {
        _responseObject = cachedJSONObject;
        return YES;
    }
    else {
        return NO;
    }
}




//- (void)willResume {}
//
//- (void)willReadCache {}
//
//- (BOOL)didReadCache { return YES; }
//
//- (void)completed {}
//
//- (void)success {}
//
//- (void)failure {}
//
//- (BOOL)willStoreCache { return YES; }



#pragma mark - tool

- (void)dynamicURLStringWithCallback:(void (^)(NSString *URLString, id parameters))callback;
{
    if ([self.urlString rangeOfString:@"##"].length <= 0) {
        callback? callback(self.urlString, self.parameters) : NULL;
        return;
    }
    
    if (![self.parameters isKindOfClass:[NSDictionary class]]) {
        callback? callback(self.urlString, self.parameters) : NULL;
        return;
    }
    
    NSDictionary *parameters = (NSDictionary *)self.parameters;
    if ([parameters count] == 0) {
        callback? callback(self.urlString, self.parameters) : NULL;
        return;
    }
    
    NSMutableArray<NSString *> *parameterNames = [NSMutableArray array];
    NSRange range = NSMakeRange(0, self.urlString.length);
    NSInteger start = -1;
    
    while (YES) {
        range = [self.urlString rangeOfString:@"##" options:NSCaseInsensitiveSearch range:range];
        if (range.length > 0) {
            if (start == -1) {
                start = range.location + range.length;
            }
            else {
                [parameterNames addObject:[self.urlString substringWithRange:NSMakeRange(start, range.location - start)]];
                start = -1;
            }
            range.location = range.location + range.length;
            range.length = self.urlString.length - range.location;
        }
        else {
            break;
        }
    }
    
    if (parameterNames.count == 0) {
        callback? callback(self.urlString, self.parameters) : NULL;
        return;
    }
    
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSString *URLString = self.urlString;
    
    for (NSString *key in parameters.allKeys) {
        for (NSString *name in parameterNames) {
            if ([key isEqualToString:name]) {
                URLString = [URLString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"##%@##", name] withString:[NSString stringWithFormat:@"%@", [parameters objectForKey:key]]];
                [mutableParameters removeObjectForKey:key];
            }
        }
    }
    
    callback? callback(URLString, (mutableParameters.count? mutableParameters : NULL) ) : NULL;
}


@end
