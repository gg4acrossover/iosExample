//
//  GGInputView.h
//  GGChatSimple
//
//  Created by viethq on 2/20/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GGInputView;

@protocol  GGInputViewDelegate<NSObject>

@optional
-(void)GGInputView: (GGInputView*)inputView sendMessenger: (NSString*)messenger;

@end

@interface GGInputView : UIView

//! properties
@property( nonatomic, strong) UIButton *mBtnSendMess;
@property( nonatomic, strong) UITextView *mTextInput;
@property( nonatomic, assign) BOOL mIsAbleSendTextMessenger;
@property( nonatomic, weak) UIViewController *mSuperView;
@property( nonatomic, weak) id<GGInputViewDelegate> mDelegate;

//! method
-(instancetype)initWithSuperView:(UIViewController*)superView;

@end
