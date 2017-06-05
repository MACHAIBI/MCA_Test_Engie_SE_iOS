//
//  NGUser.m
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import "NGUser.h"

@implementation NGUser

#pragma mark - Class Methods

static NGUser *_sharedInstance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - Instance Methods

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.idUser forKey:@"idUser"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init]))
    {
        self.idUser = [decoder decodeObjectForKey:@"idUser"];
        self.email  = [decoder decodeObjectForKey:@"email"];
        self.name   = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

+ (void)resetUser
{
    _sharedInstance.idUser  = nil;
    _sharedInstance.email   = nil;
    _sharedInstance.name    = nil;
}

@end
