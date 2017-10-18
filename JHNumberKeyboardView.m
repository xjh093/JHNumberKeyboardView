//
//  JHNumberKeyboardView.m
//  JHKit
//
//  Created by HaoCold on 2017/10/17.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import "JHNumberKeyboardView.h"

#define kJHNumberKeyboardViewDeleteTitle @"<-"

@interface JHNumberKeyboardView()
@property (strong,  nonatomic) NSMutableString *outputText;
@property (strong,  nonatomic) NSMutableArray *labelArray;
@end

@implementation JHNumberKeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = 216;
    frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), W, H);
    self = [super initWithFrame:frame];
    if (self) {
        [self jhSetupViews:frame];
    }
    return self;
}

- (void)jhSetupViews:(CGRect)frame
{
    _outputText = @"".mutableCopy;
    _labelArray = @[].mutableCopy;
    
    self.backgroundColor = [UIColor colorWithRed:209/255.0 green:213/255.0 blue:219/255.0 alpha:1];
    NSArray *details = @[@"ABC",@"DEF",@"GHI",@"JKL",@"MNO",@"PQRS",@"TUV",@"WXYZ"];
    
    CGFloat W = CGRectGetWidth(frame)/3.0, H = CGRectGetHeight(frame)/4.0;
    for (int i = 0; i < 12; ++i) {
        CGRect rect = CGRectMake(i%3*W, i/3*H, W, H);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = rect;
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = [UIFont systemFontOfSize:30];
        button.contentEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button addTarget:self action:@selector(xx_click_button:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(xx_touch_down:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(xx_touchup_outside:) forControlEvents:UIControlEventTouchUpOutside];
        [self addSubview:button];
        
        button.tag = i;
        if (i < 9) {
            [button setTitle:[@(i+1) stringValue] forState:0];
            if (i > 0) {
                [self jhSetupDetailLabel:CGRectMake(0, H*0.7, W, H*0.3) :details[i-1] :button];
            }
        }else if (i == 9){
            button.hidden = YES;
        }else if (i == 10){
            [button setTitle:@"0" forState:0];
        }else{
            [button setTitle:kJHNumberKeyboardViewDeleteTitle forState:0];
            button.backgroundColor = self.backgroundColor;
        }
    }
    
    //lines
    for (int i = 0; i < 7; ++i) {
        if (i < 3) {
            [self jhSetupLine:CGRectMake((i+1)*W, 0, 0.5, CGRectGetHeight(frame))];
        }else{
            [self jhSetupLine:CGRectMake(0, (i-3)*H, CGRectGetWidth(frame), 0.5)];
        }
    }
}

#pragma mark -

- (void)jhSetupDetailLabel:(CGRect)frame :(NSString *)text :(UIView *)superview
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.text = text;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = 1;
    label.hidden = YES;
    [superview addSubview:label];
    [_labelArray addObject:label];
}

- (void)jhSetupLine:(CGRect)frame{
    CGFloat rgb = 140/255.0;
    
    UIView *view = [[UIView alloc] init];
    view.frame = frame;
    view.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1];
    [self addSubview:view];
}

- (void)xx_touch_down:(UIButton *)button{
    if (button.tag == 11) {
        button.backgroundColor = [UIColor whiteColor];
    }else{
        button.backgroundColor = [UIColor clearColor];
    }
    
}

- (void)xx_touchup_outside:(UIButton *)button{
    if (button.tag == 11) {
        button.backgroundColor = self.backgroundColor;
    }else{
        button.backgroundColor = [UIColor whiteColor];
    }
    
}

- (void)xx_click_button:(UIButton *)button{
    if (button.tag == 11) {
        button.backgroundColor = self.backgroundColor;
    }else{
        button.backgroundColor = [UIColor whiteColor];
    }
    
    [self xx_text_changed:[button currentTitle]];
}

- (void)xx_text_changed:(NSString *)text{
    NSString *lastNumber = @"";
    if ([text isEqualToString:kJHNumberKeyboardViewDeleteTitle]) {
        if (_outputText.length > 0) {
            lastNumber = [_outputText substringFromIndex:_outputText.length - 1];
            _outputText.string = [_outputText substringToIndex:_outputText.length - 1];
        }
    }else{
        [_outputText appendString:text];
        lastNumber = text;
    }
    
    if (_limitedLength > 0) {
        if (_outputText.length >= _limitedLength) {
            _outputText.string = [_outputText substringToIndex:_limitedLength];
        }
    }
    
    if (_delegate &&
        [_delegate respondsToSelector:@selector(keyboardView:textDidChange:lsatNumber:)]) {
        [_delegate keyboardView:self textDidChange:_outputText lsatNumber:lastNumber];
    }
}

- (void)setShowDetails:(BOOL)showDetails{
    _showDetails = showDetails;
    if (showDetails) {
        //[_labelArray makeObjectsPerformSelector:@selector(setHidden:) withObject:@(0)];
        [_labelArray enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
            label.hidden = NO;
        }];
    }else{
        [_labelArray enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
            label.hidden = YES;
        }];
    }
}
@end
