//
//  JHNumberKeyboardView.m
//  JHKit
//
//  Created by HaoCold on 2017/10/17.
//  Copyright © 2017年 HaoCold. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2017 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "JHNumberKeyboardView.h"
#import "UIResponder+JHFirstResponder.h"

#define kJHNumberKeyboardViewHeight 216.0
#define kJHNumberKeyboardViewDeleteTitle @"<-"

@interface JHNumberKeyboardView()
@property (strong,  nonatomic) NSMutableArray *labelArray;

@property (nonatomic,    weak) id firstResponder;

@end

@implementation JHNumberKeyboardView

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = #define kJHNumberKeyboardViewHeight;
    frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), W, H);
    self = [super initWithFrame:frame];
    if (self) {
        //[self jhSetupViews:frame];
    }
    return self;
}

- (void)layoutSubviews{
    [_labelArray removeAllObjects];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self jhSetupViews:self.bounds];
    [self setShowDetails:_showDetails];
}

- (void)jhSetupViews:(CGRect)frame
{
    _labelArray = @[].mutableCopy;
    
    self.backgroundColor = [UIColor colorWithRed:209/255.0 green:213/255.0 blue:219/255.0 alpha:1];
    NSArray *details = @[@"ABC",@"DEF",@"GHI",@"JKL",@"MNO",@"PQRS",@"TUV",@"WXYZ"];
    
    CGFloat W = CGRectGetWidth(frame)/3.0, H = kJHNumberKeyboardViewHeight/4.0;
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
            [self jhSetupLine:CGRectMake((i+1)*W, 0, 0.5, kJHNumberKeyboardViewHeight)];
        }else{
            [self jhSetupLine:CGRectMake(0, (i-3)*H, CGRectGetWidth(frame), 0.5)];
        }
    }
    
    // iPhone X
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat maxH = MAX(size.height, size.width);
    CGFloat offsetY = 0;
    if (maxH == 812.0 || maxH == 896.0) {
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait ||
            [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) {
            offsetY = 34.0;
        }else{
            offsetY = 21.0;
        }
        
        [self jhSetupLine:CGRectMake(0, 4*H, CGRectGetWidth(frame), 0.5)];
    }
    
    CGRect newFrame = self.frame;
    newFrame.origin.y = 44 - offsetY;
    newFrame.size.height = 216 + offsetY;
    self.frame = newFrame;
    
    //NSLog(@"kb frame2:%@",NSStringFromCGRect(self.frame));
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

#pragma mark -
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
    
    id firstResponder = [UIResponder jh_currentFirstResponder];
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        if (_firstResponder != firstResponder) {
            _firstResponder = firstResponder;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xx_textChanged:) name:UITextFieldTextDidChangeNotification object:firstResponder];
        }
    }else if ([firstResponder isKindOfClass:[UITextView class]]) {
        if (_firstResponder != firstResponder) {
            _firstResponder = firstResponder;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xx_textChanged:) name:UITextViewTextDidChangeNotification object:firstResponder];
        }
    }
    else{
        _firstResponder = nil;
    }
    
    [self xx_text_changed:[button currentTitle]];
}

- (void)xx_textChanged:(NSNotification *)noti
{
    if (_firstResponder == noti.object) {
        NSString *text = [_firstResponder text];
        
        if (_limitedLength > 0 && text.length > _limitedLength) {
            [_firstResponder setText:[[_firstResponder text] substringToIndex:_limitedLength]];
        }
    }
}

- (void)xx_text_changed:(NSString *)text{
    NSString *lastNumber = @"";
    if ([text isEqualToString:kJHNumberKeyboardViewDeleteTitle]) {
        
        //NSLog(@"firstResponder: %@",_firstResponder);
        
        NSString *willDeletedText =  [_firstResponder textInRange:[_firstResponder selectedTextRange]];
        lastNumber = willDeletedText;
        
        // delete character
        [_firstResponder deleteBackward];
        
    }else{
        
        // limit judge.
        [_firstResponder insertText:text];
        if (_limitedLength > 0) {
            if ([_firstResponder text].length + text.length > _limitedLength) {
                [_firstResponder setText:[[_firstResponder text] substringToIndex:_limitedLength]];
            }
        }
        lastNumber = text;
    }
    
    if (_delegate &&
        [_delegate respondsToSelector:@selector(keyboardView:firstResponder:textDidChange:lsatNumber:)]) {
        [_delegate keyboardView:self firstResponder:_firstResponder textDidChange:[_firstResponder text] lsatNumber:lastNumber];
    }
}

#pragma mark -
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

