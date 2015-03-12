//
//  GGMessengerCell.h
//  GGChatSimple
//
//  Created by viethq on 2/20/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GGMessengerCell;
@class GGMessengerFrame;

@protocol GGMessengerCellDelegate <NSObject>

@optional
- (void)headImageDidClick:(GGMessengerCell *)cell userId:(NSString *)userId;
- (void)cellContentDidClick:(GGMessengerCell *)cell image:(UIImage *)contentImage;

@end

@interface GGMessengerCell : UITableViewCell

//! properties
@property( nonatomic, strong) UILabel *mLabelTime;
@property( nonatomic, strong) UILabel *mLabelNumb;
@property( nonatomic, strong) UIButton *mBtnAvatar;
@property( nonatomic, strong) UIButton *mBtnContent;
@property (nonatomic, strong) GGMessengerFrame *mMessageFrame;
@property( nonatomic, weak) id<GGMessengerCellDelegate> mDelegate;

//! method
-(void)setMessengerFrame:(GGMessengerFrame*)messengerF;

@end
