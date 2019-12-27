//
//  RequestCache.h
//  Music
//
//  Created by U on 2018/11/30.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Request;

@interface RequestCache : NSObject

+ (RequestCache *)sharedInstance;

// 缓存路径
@property (strong, nonatomic) NSString *diskPath;


- (void)storeCachedJSONObjectForRequest:(Request *)request;

- (NSObject *)cachedJSONObjectForRequest:(Request *)request isTimeout:(BOOL *)isTimeout;

- (void)removeCachedJSONObjectForRequest:(Request *)request;


- (void)storeCachedData:(NSData *)cachedData ForPath:(NSString *)path;

- (NSData *)cachedDataForPath:(NSString *)path TimeoutInterval:(NSTimeInterval)timeoutInterval IsTimeout:(BOOL *)isTimeout;

- (void)removeCachedDataForPath:(NSString *)path;

// 清空缓存
- (void)removeAllCachedData;

@end

