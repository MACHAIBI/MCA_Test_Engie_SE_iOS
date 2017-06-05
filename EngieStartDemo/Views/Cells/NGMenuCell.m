//
//  NGMenuCell.m
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import "NGMenuCell.h"

@interface NGMenuCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewCell;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation NGMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    NSString *fontName = selected ? @"helvetica-Bold" : @"helvetica";
    self.titleLabel.font = [UIFont fontWithName:fontName size:18];
}

- (void)updateWithMenuType:(NGMenuType)type;
{
    NSString *imageName = @"";
    NSString *title = @"";
    switch (type)
    {
        case NGMenuTypeMyAccount:
            title = _T(@"NG_Home_Menu_MyAccount.title");
            imageName = @"Account";
            break;
        case NGMenuTypeConsomation:
            title = _T(@"NG_Home_Menu_Comsumption.title");
            imageName = @"consumption";
            break;
        case NGMenuTypeHistorique:
            title = _T(@"NG_Home_Menu_History.title");
            imageName = @"history";
            break;
        case NGMenuTypeAstuce:
            title = _T(@"NG_Home_Menu_History.trick");
            imageName = @"idea";
            break;
        case NGMenuTypeQualifyHome:
            title = _T(@"NG_Home_Menu_History.quality");
            imageName = @"home";
            break;
        default:
            break;
    }
    [self.imageViewCell setImage:[UIImage imageNamed:imageName]];
    self.titleLabel.text = title;
}

@end
