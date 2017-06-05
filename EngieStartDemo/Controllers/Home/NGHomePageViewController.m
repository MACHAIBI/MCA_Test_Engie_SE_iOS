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
#import "NSString+Engie.h"

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
    
#ifdef DEBUG
    self.emailTextField.text = @"majid.chaibi@gmail.com";
#endif
    
    [self observeEmailTextField];
    [self observeCreateAccount];

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
        }
        else
        {
            [self errorAlert:error];
            [ProgressHUD showError];
        }
    }];
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
