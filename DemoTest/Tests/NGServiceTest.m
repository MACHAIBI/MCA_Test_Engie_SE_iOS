//
//  NGServiceTest.m
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WKRequest.h"

#pragma mark - Constantes

// Parameters
static NSInteger const kExpectationTimeOut      = 30;
static NSString * kCreatAccountURL               = @"http://jsonplaceholder.typicode.com/users";

// Just for pretty printed logs
static NSString * kStartLogForTestCreatedAccount = @"[UnitTest][Account Created]";

@interface NGServiceTest : XCTestCase

@end

@implementation NGServiceTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreatAccount
{
    NSDictionary *params = @{@"user":@{@"email":@"myaccount@email.com", @"name":@""}};
    [self exepectionWithDescription:@"Account is created expected" startingLog:kStartLogForTestCreatedAccount executeBlock:^(XCTestExpectation *expectation) {
        [[WKRequest sharedInstance] requestWithUrl:kCreatAccountURL
                                        parameters:params method:WKRequestMethodPost completion:^(NSError *error, id data)
         {
             if(!error)
             {
                 [expectation fulfill];
             }
             else
             {
                 XCTFail(@"%@", error);
             }
         }];
    }];
}

//--------------------------------------------------------------------------------------------------
#pragma mark - Asynchronous Test
//--------------------------------------------------------------------------------------------------

// We have to move it to a category. Mostly if we have many tests files.
- (void)exepectionWithDescription:(NSString *)description startingLog:(NSString const *)startLog executeBlock:(void(^)(XCTestExpectation *expectation))block
{
    __weak XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%@%@", startLog, description]];
    
    block(expectation);
    
    [self waitForExpectationsWithTimeout:kExpectationTimeOut handler:^(NSError * _Nullable error) {
        if(error)
        {
            XCTFail(@"%@Unit test failed with error : %@", startLog, error);
        }
    }];
}

- (void)wait:(NSTimeInterval)seconds completion:(void(^)(void))completion
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(completion) completion();
    });
}

//--------------------------------------------------------------------------------------------------
#pragma mark - Performance
//--------------------------------------------------------------------------------------------------

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
