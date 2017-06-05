//
//  NGMenuCell.h
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Defines & Constants

typedef NS_ENUM (NSInteger, NGMenuType) {
    NGMenuTypeMyAccount = 0,
    NGMenuTypeConsomation,
    NGMenuTypeHistorique,
    NGMenuTypeAstuce,
    NGMenuTypeQualifyHome,
    NGMenuCount
};

@interface NGMenuCell : UITableViewCell

- (void)updateWithMenuType:(NGMenuType)type;

@end
