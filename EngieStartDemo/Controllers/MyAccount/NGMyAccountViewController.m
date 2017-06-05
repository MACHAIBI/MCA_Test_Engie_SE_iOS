//
//  NGMyAccountViewController.m
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import "NGMyAccountViewController.h"
#import "SWRevealViewController.h"

@interface NGMyAccountViewController ()

@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property (weak, nonatomic) IBOutlet UILabel *idUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *NameUserLabel;
@property (weak, nonatomic) IBOutlet UINavigationItem *navTitle;

@end

@implementation NGMyAccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customSetup];
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController)
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector(revealToggle:)];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}

- (void)updateUI
{
    NGUser *user = [NGUser sharedInstance];
    
    self.navTitle.title         = _T(@"NG_Home_Menu_MyAccount.title");
    self.idUserLabel.text       = [NSString stringWithFormat:@"%@ : %@",_T(@"NG_MyAccount.id"),user.idUser];
    self.emailUserLabel.text    = [NSString stringWithFormat:@"%@ : %@",_T(@"NG_MyAccount.email"),user.email];
    self.NameUserLabel.text     =  user.name.length ? [NSString stringWithFormat:@"%@ : %@",_T(@"NG_MyAccount.name"), user.name]: @"";
}

@end
