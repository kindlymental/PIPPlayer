//
//  Request.h
//  Music
//
//  Created by U on 2018/11/30.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RequestHandler.h"

@class Request;

@interface Request : NSObject <RequestHandlerDelegate>

#pragma mark -  请求链接 方式 参数

@property (strong, nonatomic) NSString *urlString;

@property (assign, nonatomic) HTTPMethod method;

@property (strong, nonatomic) NSObject *parameters;

#pragma mark - 关于请求结果

// 请求状态
@property (readonly) NSURLSessionTaskState state;
// 请求数据
@property (strong, nonatomic, readonly) id responseObject;
// 请求错误
@property (strong, nonatomic, readonly) NSError *error;

/**
 *  请求完成后会置为NULL
 */
@property (copy, nonatomic) void (^completionBlock)(__kindof Request * request);


#pragma mark Cache : 如果缓存时长小于等于0或者willStoreCache,将不会进行缓存

@property (assign, nonatomic) NSTimeInterval cacheTimeoutInterval;  // 缓存时长

@property (strong, nonatomic) NSString *groupName;  // 缓存位置

@property (strong, nonatomic) NSString *identifier;   // （groupName）缓存位置

@property (assign, nonatomic) BOOL mustFromNetwork;  // 是否必须请求接口，不从缓存取数据

@property (assign, nonatomic) BOOL willStoreCache;   // 是否需要缓存


// 初始化方法
+ (instancetype)request;


/** 开始请求 */
- (__kindof Request *)startWithCompletionBlock:(void (^)(__kindof Request *request))completionBlock;

/** 暂停请求 */
- (void)pause;

/** 结束请求 */
- (void)stop;




//- (void)willResume __attribute__((objc_requires_super));
//
//- (void)willReadCache __attribute__((objc_requires_super));
//
//- (BOOL)didReadCache;
//
//- (void)completed __attribute__((objc_requires_super));
//
//- (void)success __attribute__((objc_requires_super));
//
//- (void)failure __attribute__((objc_requires_super));

@end

