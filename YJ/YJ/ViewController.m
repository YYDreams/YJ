//
//  ViewController.m
//  YJ
//
//  Created by flowerflower on 2021/5/21.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setupInit];
    
    
    
}
- (void)setupInit{
    [self.phoneTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.codeTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.loginBtn setBackgroundColor:[[UIColor colorWithHex:0x5B9AF7] colorWithAlphaComponent:0.3f]];
    self.loginBtn.enabled = false;
    
    self.loginBtn.layer.cornerRadius = 21;
    self.loginBtn.layer.shadowColor = [UIColor colorWithRed:91/255.0 green:154/255.0 blue:247/255.0 alpha:0.3].CGColor;
    self.loginBtn.layer.shadowOffset = CGSizeMake(0,2);
    self.loginBtn.layer.shadowOpacity = 1;
    self.loginBtn.layer.shadowRadius = 4;
    
}

- (IBAction)codeBtnOnClick:(UIButton *)sender {
    
    if (self.phoneTextField.text.length == 0 || (self.phoneTextField.text.length != 11)) {
        return;
    }
    [self openCountdown:60];
    
//    [MBProgressHUD LY_ShowHUD:true];
    [HHHudManager showHudLoadingView];
    
//    return;
    [HTTPRequest POST:@"/jeeplus/android/sendWaiterCaptcha" parameter:@{@"phoneNumber":SCString(self.phoneTextField.text, @"")} success:^(id resposeObject) {
        if (Success) {
            
        }else{

        [HHHudManager showWarnText:resposeObject[@"msg"]?:@"获取失败"];
            
        }
        [HHHudManager hideHudLoadingView];
        
    } failure:^(NSError *error) {
        
        [HHHudManager hideHudLoadingView];
        
    }];
    
}

- (void)textFieldTextChange:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    } else if (textField == self.codeTextField) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }

    }
    
    if (!kStringIsEmpty(self.phoneTextField.text) && ! kStringIsEmpty((self.codeTextField.text))) {
        
        self.loginBtn.enabled  = true;
        [self.loginBtn setBackgroundColor:[[UIColor colorWithHex:0x5B9AF7] colorWithAlphaComponent:1.f]];
    }else{
        self.loginBtn.enabled  = false;
        [self.loginBtn setBackgroundColor:[[UIColor colorWithHex:0x5B9AF7] colorWithAlphaComponent:0.3f]];
    }
}

- (void)openCountdown:(NSInteger)reaskDuration
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval secondNow =[dat timeIntervalSince1970];
    __block NSTimeInterval endSecond = secondNow + reaskDuration;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    self.codeBtn.selected = YES;
    self.codeBtn.enabled = NO;
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        __strong typeof(self) strongSelf = weakSelf;
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSInteger secondNow =[dat timeIntervalSince1970];
        NSInteger time = endSecond - secondNow;
        if(time <= 0){
            dispatch_source_cancel(_timer);
            strongSelf.timer = nil;
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf.codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
                strongSelf.codeBtn.selected = NO;
                strongSelf.codeBtn.enabled = YES;
            });
        } else {
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf.codeBtn setTitle:[NSString stringWithFormat:@"%lds", time] forState:UIControlStateNormal];
                
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    self.timer = _timer;
}

- (IBAction)loginOnClick:(UIButton *)sender {
    if (![self checkInputContent]) {
        return;
    }
    
    [self.phoneTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    
}


- (BOOL)checkInputContent
{
    if (self.phoneTextField.text.length == 0) {
        [HHHudManager showHudWithText:@"请输入手机号"];
        
        return NO;
    }
    
    if (self.phoneTextField.text.length != 11) {
        [HHHudManager showHudWithText:@"请输入11位手机号"];
        return NO;
    }
    
    if (self.codeTextField.text.length == 0) {
        [HHHudManager showHudWithText:@"请输入短信验证码"];
        return NO;
    }
    

    return YES;
}



@end
