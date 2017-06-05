//
//  NGService+Registration.h
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import "NGService.h"

@interface NGService (Registration)

+ (void)registrationWithDictionary:(NSDictionary*)dict completionHandler:(CompletionHandler)completionHandler;

@end
