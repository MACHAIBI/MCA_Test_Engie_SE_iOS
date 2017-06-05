//
//  EngieStartDemoUITests.m
//  EngieStartDemoUITests
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface EngieStartDemoUITests : XCTestCase

@end

@implementation EngieStartDemoUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMyApplication{
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Register with Email"] tap];
    
    XCUIElement *emailRequiredTextField = app.textFields[@"Email (Required)"];
    [emailRequiredTextField tap];
    [emailRequiredTextField typeText:@"majid.chaibi@gmail.com"];
    XCUIElement *nameTextField = app.textFields[@"Name"];
    [nameTextField tap];
    [nameTextField typeText:@"CHAIBI"];
    [[[XCUIApplication alloc] init].buttons[@"Create My Account"] tap];
}


@end
