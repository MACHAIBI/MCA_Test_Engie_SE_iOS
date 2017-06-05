//
//  NGUser.h
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGUser : NSObject

@property (nonatomic, strong) NSString *idUser;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *name;

#pragma mark - Class Methods

+ (id)sharedInstance;

#pragma mark - Instance Methods

+ (void)resetUser;

@end
