//
//  ViewController.m
//  JHNumberKeyboardViewDemo
//
//  Created by HaoCold on 2018/12/11.
//  Copyright © 2018 HaoCold. All rights reserved.
//

#import "ViewController.h"
#import "JHNumberKeyboardView.h"

#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<JHNumberKeyboardViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"inputView";
    
    {
    
    JHNumberKeyboardView *keyboard = [[JHNumberKeyboardView alloc] initWithFrame:CGRectMake(0, kScreenHeight-216, kScreenWidth, 216)];
    //keyboard.delegate = self;
    keyboard.useAsInputview = YES;
    keyboard.limitedLength = 10;
    //keyboard.showDetails = YES;  // default is YES.

    _textField.inputView = keyboard;
    
    }

    {
    JHNumberKeyboardView *keyboard = [[JHNumberKeyboardView alloc] initWithFrame:CGRectMake(0, kScreenHeight-216, kScreenWidth, 216)];
    //keyboard.delegate = self;
    keyboard.useAsInputview = YES;
    keyboard.limitedLength = 5;
    //keyboard.showDetails = YES;  // default is YES.
    
    _codeTextField.inputView = keyboard;
    
    }
}

#pragma mark - JHNumberKeyboardViewDelegate

- (void)keyboardView:(JHNumberKeyboardView *)keyboard firstResponder:(id)firstResponder textDidChange:(NSString *)text lsatNumber:(NSString *)number{
    
    NSLog(@"text:%@,number:%@",text,number);
    
    if (firstResponder == _textField) {
        // code goes here.
    }else if (firstResponder == _codeTextField) {
        // code goes here.
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
