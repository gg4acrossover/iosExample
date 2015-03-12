//
//  GGInputView.m
//  GGChatSimple
//
//  Created by viethq on 2/20/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import "GGInputView.h"
#import "GGDefine.h"

static const CGFloat VIEW_H = 40.0f;
static const CGFloat ORIGIN_Y_BTN = 5.0f;
static const CGFloat SIZE_BTN = 35.0f;
static const CGFloat TXT_INPUT_H = 30.0f;

@interface  GGInputView()<UITextViewDelegate>

@property(nonatomic, strong) UILabel *mPlaceHolder;

@end

@implementation GGInputView

#pragma mark init
-(instancetype)initWithSuperView:(UIViewController *)superView
{
    CGSize s = SCREEN_SIZE();
    CGRect recInputView = CGRectMake( 0, s.height - VIEW_H, s.width, VIEW_H);
    
    self = [super initWithFrame:recInputView];
    if ( self)
    {
        self.backgroundColor = [UIColor grayColor];
        
        /* btn send mess */
        self.mBtnSendMess = [UIButton buttonWithType:UIButtonTypeCustom];
        self.mBtnSendMess.frame = CGRectMake( s.width - VIEW_H, ORIGIN_Y_BTN, SIZE_BTN, TXT_INPUT_H);
        [self.mBtnSendMess setTitle:@"send" forState: UIControlStateNormal];
        
        self.mBtnSendMess.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [self.mBtnSendMess setBackgroundImage: [UIImage imageNamed:@"chat_send_message"]
                                     forState: UIControlStateNormal ];
        [self.mBtnSendMess setBackgroundImage: [UIImage imageNamed:@"chat_send_message"]
                                     forState: UIControlStateHighlighted];
        
        [self.mBtnSendMess addTarget: self
                              action: @selector(_sendMessCallback:)
                    forControlEvents: UIControlEventTouchUpInside];
        
        [self addSubview: self.mBtnSendMess];
        
        /* txt input */
        self.mTextInput =
        [[UITextView alloc] initWithFrame:CGRectMake( 45.0f, 5.0f,
                                                     s.width - 45.0f*2.0f, VIEW_H - 10.0f)];
        self.mTextInput.layer.cornerRadius = 4.0f;
        self.mTextInput.layer.masksToBounds = TRUE;
        self.mTextInput.layer.borderWidth = 1;
        self.mTextInput.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
        self.mTextInput.delegate = self;
    
        
        [self addSubview:self.mTextInput];
        
        /* place holder */
        self.mPlaceHolder = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, 200.0f, TXT_INPUT_H)];
        self.mPlaceHolder.text = @"input text here";
        self.mPlaceHolder.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8f];
        [self.mTextInput addSubview: self.mPlaceHolder];
        
        
        /* add notify */
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(textViewDidEndEditing:)
                                                     name: UIKeyboardWillHideNotification
                                                   object: nil];
    }
    
    return self;
}

#pragma mark - btn callback
-(void)_sendMessCallback:(UIButton*)sender
{
    [self.mTextInput resignFirstResponder];
    if ( [self.mDelegate respondsToSelector:@selector(GGInputView:sendMessenger:)])
    {
        if(self.mTextInput.text.length)
        {
            [self.mDelegate GGInputView:self sendMessenger:self.mTextInput.text];
        }
    }
}

#pragma mark - textview delegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.mPlaceHolder.hidden = textView.text.length > 0;
}

-(void)textViewDidChange:(UITextView *)textView
{
    self.mPlaceHolder.hidden = textView.text.length > 0;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.mPlaceHolder.hidden = self.mTextInput.text.length > 0;
}

@end
