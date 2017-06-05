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

//Category
#import "NSString+Extended.h"

//Model
#import "NGUser.h"

//Services
#import "NGService+Registration.h"

//third party
#import "ReactiveObjC.h"
#import "ProgressHUD.h"

@interface NGHomePageViewController ()

@property (weak, nonatomic) IBOutlet NGRoundButton *registrationButton;
@property (weak, nonatomic) IBOutlet NGRoundButton *createAccountButton;

@property (weak, nonatomic) IBOutlet UITextField   *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField   *nameTextField;

@property (weak, nonatomic) IBOutlet UIView        *creatAccountView;

@end

@implementation NGHomePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self pushMyContactIfConnected];
    [self observeEmailTextField];
    [self observeCreateAccount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

/* observe emailTextField modification and check if is a Valid Email*/
- (void)observeEmailTextField
{
    @weakify(self)
    [[self.emailTextField.rac_textSignal
      map:^id(NSString *text) {
          BOOL isEmailValid = [text isEmail];
          UIColor *color = isEmailValid ? [UIColor blackColor] : [UIColor redColor];
          return color;
      }]
     subscribeNext:^(UIColor *color) {
         @strongify(self)
         self.emailTextField.textColor = color;
     }];
}

- (void)observeCreateAccount
{
    self.createAccountButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^(id _) {
        
        if ([self.emailTextField.text isEmail])
        {
            [self createMyAccount];
        }
        else
        {
            [self emptyFormAlert];
        }
        return [RACSignal empty];
    }];
}

- (void)createMyAccount
{
    [ProgressHUD show];
    
    NSDictionary *params = @{@"user":@{ @"email":self.emailTextField.text,
                                        @"name":self.nameTextField.text}};
    
    [NGService registrationWithDictionary:params completionHandler:^(NSError *error, NGUser *user){
        if (!error && user.email != nil)
        {
            [NGAppConfig saveUser:user];
            [ProgressHUD showSuccess];
            [self performSegueWithIdentifier:@"PushMyAccount" sender:self];
        }
        else
        {
            [self errorAlert:error];
            [ProgressHUD showError];
        }
    }];
}
- (void)pushMyContactIfConnected
{
    NGUser * user =[NGAppConfig loadUser];
    if (user.email != nil)
    {
        [[NGUser sharedInstance] setIdUser:user.idUser];
        [[NGUser sharedInstance] setEmail:user.email];
        [[NGUser sharedInstance] setName:user.name];
        [self performSegueWithIdentifier:@"PushMyAccount" sender:self];
    }
}

#pragma mark - Alert methods

- (void)emptyFormAlert
{
    [self cancelAlertWithTitle:_T(@"NG_Registration_Form_Incomplete.title")
                       message:_T(@"NG_Registration_Form_Incomplete.message")];
}

- (void)errorAlert:(NSError*)error
{
    NSString *message = [NSString stringWithFormat:@"%ld - %@",(long)error.code,error.userInfo];
    [self cancelAlertWithTitle:_T(@"NG_Global_Error")
                       message:message];
}

#pragma mark - IBAction
- (IBAction)goToRegistrationView:(id)sender
{
    [self displayAccountView:YES];
}

- (IBAction)backToRegistration:(id)sender
{
    [self displayAccountView:NO];
}


@end
