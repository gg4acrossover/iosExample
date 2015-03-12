//
//  GGMessengerFrame.h
//  GGChatSimple
//
//  Created by viethq on 2/20/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GGMessenger;

@interface GGMessengerFrame : NSObject

//! properties
@property( nonatomic, assign) CGRect mNameF;
@property( nonatomic, assign) CGRect mIconF;
@property( nonatomic, assign) CGRect mtimeF;
@property( nonatomic, assign) CGRect mContentF;

@property( nonatomic, assign) CGFloat mCellHeight;
@property( nonatomic, strong) GGMessenger *mMessenger;
@property( nonatomic, assign) BOOL mIsShowTime;

//! method
-(void)setMessenger:(GGMessenger*)messenger;

@end
