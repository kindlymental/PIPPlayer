//
//  RequestHandler.h
//  Music
//
//  Created by U on 2018/11/30.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTTPMethod) {
    HTTPMethodGet,
    HTTPMethodPost,
};

typedef NS_ENUM(NSInteger, NetworkReachabilityStatus) {
    NetworkReachabilityStatusUnknown          = -1,
    NetworkReachabilityStatusNotReachable     = 0,
    NetworkReachabilityStatusReachableViaWWAN = 1,
    NetworkReachabilityStatusReachableViaWiFi = 2,
};

@class Request;

@protocol RequestHandlerDelegate <NSObject>

- (void)requestHandlerResponseObject:(id)responseObject;

- (void)requestHandlerError:(NSError *)error;

@end

@interface RequestHandler : NSObject

@property (readonly, nonatomic, assign) NetworkReachabilityStatus networkReachabilityStatus;

@property (assign, nonatomic) NSTimeInterval timeoutInterval;

+ (RequestHandler *)sharedInstance;

- (NSURLSessionDataTask *)sendRequestWithURLString:(NSString *)URLString Method:(HTTPMethod)method parameters:(id)parameters delegate:(id<RequestHandlerDelegate>)delegate;


@end
