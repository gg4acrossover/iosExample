//
//  GGMessenger.h
//  GGChatSimple
//
//  Created by viethq on 2/20/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GGMessengerType)
{
    GGMessengerTypeText,
    GGMessengerTypePhoto
};

typedef NS_ENUM( NSInteger, GGMessengerFrom)
{
    GGMessengerFromMe = 100,
    GGMessengerFromFriend
};

@interface GGMessenger : NSObject

//! properties
@property( nonatomic, copy) NSString *mStrIcon;
@property( nonatomic, copy) NSString *mStrUId;
@property( nonatomic, copy) NSString *mStrTime;
@property( nonatomic, copy) NSString *mStrName;

@property( nonatomic, copy) NSString *mStrContent;
@property( nonatomic, copy) UIImage *mPic;
@property( nonatomic, assign) BOOL mIsShowDateLabel;
@property( nonatomic, assign) GGMessengerType mMessengerType;
@property( nonatomic, assign) GGMessengerFrom mMessengerFrom;

//! method
- (void)setWithDict:(NSDictionary *)dict;

@end
