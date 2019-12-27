//
//  VideoURLViewModel.m
//  Music
//
//  Created by U on 2018/12/12.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#import "VideoURLViewModel.h"
#import <WebKit/WKWebView.h>

NSMutableArray<VideoURLViewModel *> *__Queue;

@interface VideoURLViewModel () <NSURLSessionDelegate, WKUIDelegate, WKNavigationDelegate>

@property (nonatomic,assign) NSInteger aid;

@property (nonatomic,assign) NSInteger cid;

@property (nonatomic,assign) NSInteger page;

@property (nonatomic,strong) NSURLSession *session;

@property (nonatomic,strong) WKWebView *webView;

@property (nonatomic,strong) void (^completionBlock)(NSURL *);

@end

@implementation VideoURLViewModel {
    
}

- (instancetype)initWithAid:(NSInteger)aid cid:(NSInteger)cid page:(NSInteger)page completionBlock:(void (^)(NSURL *))completionBlock {
    self = [super init];
    if (!self) {
        return NULL;
    }
    _aid = aid;
    _cid = cid;
    _page = page;
    _completionBlock = [completionBlock copy];
    return self;
}

+ (void)requestVideoURLWithAid:(NSInteger)aid cid:(NSInteger)cid page:(NSInteger)page completionBlock:(void (^)(NSURL *))completionBlock {
    
    if (!__Queue) {
        __Queue = [NSMutableArray array];
    }
    
    VideoURLViewModel *operation = [[VideoURLViewModel alloc] initWithAid:aid cid:cid page:page completionBlock:completionBlock];
    
    if ([__Queue count] == 0) {
        [__Queue addObject:operation];
        [operation getVideoURLMode1];
    }
    else {
        [__Queue addObject:operation];
    }
}

- (void)getVideoURLMode1 {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.bilibilijj.com/Files/DownLoad/%ld.mp4/www.bilibilijj.com.mp4?mp3=true", _cid]];
    
    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *downloadTask;
    downloadTask = [_session dataTaskWithRequest:request];
    [downloadTask resume];
}

- (void)getVideoURLMode2 {
//    [NSURLProtocol registerClass:[VideoURLProtocol class]];
//    [self performSelector:@selector(webViewVideoURL:) withObject:NULL afterDelay:20];
//    _webView = [[UIWebView alloc] init];
//    NSString *urlString = [NSString stringWithFormat:@"http://www.bilibili.com/mobile/video/av%ld.html#page=%ld", _aid, _page];
//    _webView.delegate = self;
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (void)completionWithURL:(NSURL *)url {
    _session = NULL;
    _completionBlock ? _completionBlock(url) : NULL;
    _completionBlock = NULL;
    [__Queue removeObject:self];
    [__Queue.firstObject getVideoURLMode1];
}

#pragma mark NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    [task cancel];
    [_session finishTasksAndInvalidate];
    [self completionWithURL:request.URL];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    [dataTask cancel];
    [_session finishTasksAndInvalidate];
    completionHandler(NSURLSessionResponseCancel);
    
    [self getVideoURLMode2];
    
}

@end
