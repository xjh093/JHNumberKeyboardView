//
//  JHNumberKeyboardView.h
//  JHKit
//
//  Created by HaoCold on 2017/10/17.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHNumberKeyboardView;

@protocol JHNumberKeyboardViewDelegate <NSObject>

- (void)keyboardView:(JHNumberKeyboardView *)keyboard textDidChange:(NSString *)text lsatNumber:(NSString *)number;

@end

@interface JHNumberKeyboardView : UIView
/// show more details. default is NO.
@property (assign,  nonatomic) BOOL  showDetails;
/// text max length. 0 means no limited.
@property (assign,  nonatomic) NSUInteger limitedLength;
@property (weak,    nonatomic) id <JHNumberKeyboardViewDelegate> delegate;
@end
