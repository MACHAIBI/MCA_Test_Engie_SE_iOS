//
//  NGService+Registration.m
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import "NGService+Registration.h"
//Model
#import "NGUser.h"

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
                                            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
                                            
                                            NGUser *user = [self parseUser:json];

                                            completionHandler(error,user);
                                            
                                        }];
}

+ (NGUser*)parseUser:(NSDictionary*)dict
{
    NGUser *user    = [NGUser sharedInstance];
    user.idUser     = dict[@"id"];
    user.email      = dict[@"user"][@"email"];
    user.name       = dict[@"user"][@"name"];
    
    return user;
}

@end
