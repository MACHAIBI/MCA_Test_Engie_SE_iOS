//
//  NGHomePageViewController.m
//  EngieStartDemo
//
//  Created by CHAIBI  on 05/06/2017.
//  Copyright © 2017 Engie. All rights reserved.
//

#import "NGHomePageViewController.h"

// Views
#import "NGRoundButton.h"

@interface NGHomePageViewController ()

@property (weak, nonatomic) IBOutlet NGRoundButton *registrationButton;
@property (weak, nonatomic) IBOutlet NGRoundButton *createAccountButton;
@property (weak, nonatomic) IBOutlet UIView        *creatAccountView;

@end

@implementation NGHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private methods

- (void)displayAccountView:(BOOL)display
{
    [UIView transitionWithView:self.creatAccountView
                      duration:0.6
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.creatAccountView.hidden = !display;
                        self.registrationButton.hidden = display;
                    }
                    completion:NULL];
}

#pragma mark - IBAction
- (IBAction)registrationAction:(id)sender
{
    [self displayAccountView:YES];
}

- (IBAction)backToRegistration:(id)sender
{
    [self displayAccountView:NO];
}


@end
