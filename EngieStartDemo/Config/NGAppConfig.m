//
//  NGAppConfig.m
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import "NGAppConfig.h"


#pragma Constants
NSString *const KUserKey = @"UserKey";

@implementation NGAppConfig

// i used NSUserDefault for TestDemo but it is preferable to use keychain for client

+ (void)saveUser:(NGUser*)user
{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:user];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:KUserKey];
    [defaults synchronize];
}

+ (NGUser*)loadUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:KUserKey];
    NGUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return user;
}

+ (void)removeUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:KUserKey];
    [defaults synchronize];
    
    [NGUser resetUser];
}
@end
