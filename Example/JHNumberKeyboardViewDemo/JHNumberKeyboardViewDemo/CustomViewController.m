//
//  CustomViewController.m
//  JHNumberKeyboardViewDemo
//
//  Created by HaoCold on 2018/12/11.
//  Copyright © 2018 HaoCold. All rights reserved.
//

#import "CustomViewController.h"
#import "JHNumberKeyboardView.h"

#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width

@interface CustomViewController ()<JHNumberKeyboardViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"customView";
    
    JHNumberKeyboardView *keyboard = [[JHNumberKeyboardView alloc] initWithFrame:CGRectMake(0, kScreenHeight-216, kScreenWidth, 216)];
    keyboard.delegate = self;
    [self.view addSubview:keyboard];
}

#pragma mark - JHNumberKeyboardViewDelegate

- (void)keyboardView:(JHNumberKeyboardView *)keyboard firstResponder:(id)firstResponder textDidChange:(NSString *)text lsatNumber:(NSString *)number{
    
    NSLog(@"text:%@,number:%@",text,number);
    
    if ([text isEqualToString:@"<-"]) {
        if (_label.text.length > 0) {
            _label.text = [_label.text substringWithRange:NSMakeRange(0, _label.text.length-1)];
        }
    }else if (_label.text.length < 10) {
        _label.text = [NSString stringWithFormat:@"%@%@",_label.text,text];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
