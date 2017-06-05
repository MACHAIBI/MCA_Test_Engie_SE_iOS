//
//  NGService.m
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import "NGService.h"

@implementation NGService

#pragma mark - Class Methods

static NGService *_sharedInstance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - POST

- (NSNumber *)postRequestWithURL:(NSString *)url parameters:(id)parameters completion:(CompletionHandler)completion
{
    return [self requestWithPath:url parameters:parameters method:WKRequestMethodPost completion:completion];
}

#pragma mark - GET

- (NSNumber *)getRequestWithURL:(NSString *)url parameters:(id)parameters completion:(CompletionHandler)completion
{
    return [self requestWithPath:url parameters:parameters method:WKRequestMethodGet completion:completion];
}

#pragma mark - private methods

- (NSNumber *)requestWithPath:(NSString *)url parameters:(id)parameters method:(WKRequestMethod)method completion:(CompletionHandler)completion
{
    return [[WKRequest sharedInstance] requestWithUrl:url parameters:parameters method:method completion:completion];
}

@end
