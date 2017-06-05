//
//  NGSideMenuViewController.m
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import "NGSideMenuViewController.h"

//Views
#import "NGMenuCell.h"
#import "NGRoundButton.h"

//third party
#import "SWRevealViewController.h"

@interface NGSideMenuViewController ()

@property(strong, nonatomic) IBOutlet UITableView *menuTableView;
@property(strong, nonatomic) IBOutlet NGRoundButton *disconnectionButton;

@end

@implementation NGSideMenuViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.menuTableView.alwaysBounceVertical = NO;
    
    [self.disconnectionButton setTitle:_T(@"NG_Home_Menu_Disconnection_Title")
                             forState:UIControlStateNormal+UIControlStateHighlighted+UIControlStateSelected];
    
    [self.menuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                    animated:NO scrollPosition:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NGMenuCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _T(@"NG_Home_Menu_Title");
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cellMenu";
    
    NGMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell updateWithMenuType:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0)
    {
        [self performSegueWithIdentifier:@"PushMyAccount" sender:self];
    }
    else
    {
        [self.revealViewController rightRevealToggleAnimated:YES];
    }
}

#pragma mark Private

- (IBAction)disconnection:(id)sender
{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:_T(@"NG_Home_Menu_Disconnection_Title")
                                message:_T(@"NG_Home_Menu_Disconnection_Message")
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesButton = [UIAlertAction actionWithTitle:_T(@"NG_Global_Yes")
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          [NGAppConfig removeUser];
                                                          [self.navigationController popToRootViewControllerAnimated:YES];
                                                      }];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:_T(@"NG_Global_Cancel")
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelButton];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
    [self.revealViewController rightRevealToggleAnimated:NO];
}

@end
