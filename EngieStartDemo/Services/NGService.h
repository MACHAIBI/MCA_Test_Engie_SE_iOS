//
//  NGService.h
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WKRequest.h>

/** This class centralizes webservice calls */
@interface NGService : NSObject


#pragma mark - Property

@property(strong, nonatomic)NSString *baseURL;

#pragma mark - Class Methods

+ (id)sharedInstance;

#pragma mark - POST

- (NSNumber *)postRequestWithURL:(NSString *)url parameters:(id)parameters completion:(CompletionHandler)completion;

#pragma mark - GET

- (NSNumber *)getRequestWithURL:(NSString *)url parameters:(id)parameters completion:(CompletionHandler)completion;

@end
