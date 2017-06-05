//
//  NGService+Registration.m
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import "NGService+Registration.h"

#pragma mark - Defines & Constants
static NSString *registrationURL = @"http://jsonplaceholder.typicode.com/users";

@implementation NGService (Registration)

+ (void)registrationWithDictionary:(NSDictionary*)dict completionHandler:(CompletionHandler)completionHandler
{
    [[NGService sharedInstance] postRequestWithURL:registrationURL
                                        parameters:dict
                                        completion:^(NSError *error, id data) {
                                            
                                            if (error) completionHandler(error,nil);
                                            
                                            NSError *localError = nil;
                                            NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
                                            
                                            completionHandler(error,parsedObject);
                                            
                                        }];
}

@end
