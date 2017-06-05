//
//  NGAppConfig.h
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import <Foundation/Foundation.h>
//Model
#import "NGUser.h"

@interface NGAppConfig : NSObject


/** save user using NSUserDefault */
+ (void)saveUser:(NGUser*)user;

/** load user from NSUserDefault */

+ (NGUser*)loadUser;

/** remove user from NSUserDefault and clean SharedInstance */

+ (void)removeUser;

@end
