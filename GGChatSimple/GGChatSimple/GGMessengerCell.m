//
//  GGMessengerCell.m
//  GGChatSimple
//
//  Created by viethq on 2/20/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import "GGMessengerCell.h"
#import "GGDefine.h"
#import "GGMessengerFrame.h"
#import "GGMessenger.h"

@interface  GGMessengerCell()

@property( nonatomic, strong) UIView *mAvatarBorder;

@end

@implementation GGMessengerCell

#pragma mark - init
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        /* lbl time */
        self.mLabelTime = [[UILabel alloc] init];
        self.mLabelTime.textAlignment = NSTextAlignmentCenter;
        self.mLabelTime.textColor = [UIColor grayColor];
        self.mLabelTime.font = FONT_CHAT();
        
        [self.contentView addSubview: self.mLabelTime];
        
        /* avatar border */
        self.mAvatarBorder = [[UIView alloc] init];
        self.mAvatarBorder.layer.cornerRadius = 22.0f;
        self.mAvatarBorder.layer.masksToBounds = TRUE;
        self.mAvatarBorder.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4f];
        [self.contentView addSubview: self.mAvatarBorder];
        
        /* avatar */
        self.mBtnAvatar = [UIButton buttonWithType:UIButtonTypeCustom];
        self.mBtnAvatar.layer.cornerRadius = 20.0f;
        self.mBtnAvatar.layer.masksToBounds = TRUE;
        [self.mBtnAvatar addTarget: self
                            action:@selector(_clickAvatarCallback:)
                  forControlEvents:UIControlEventTouchUpInside];
        
        [self.mAvatarBorder addSubview:self.mBtnAvatar];
        
        /* lbl num */
        self.mLabelNumb = [[UILabel alloc] init];
        self.mLabelNumb.textColor = [UIColor redColor];
        self.mLabelNumb.textAlignment = NSTextAlignmentCenter;
        self.mLabelNumb.font = FONT_CHAT();
        [self.contentView addSubview:self.mLabelNumb];
        
        /* btn content */
        self.mBtnContent = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mBtnContent setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.mBtnContent.titleLabel.font = FONT_CONTENT();
        self.mBtnContent.titleLabel.numberOfLines = 0;

        [self.contentView addSubview: self.mBtnContent];
    }
    
    return self;
}

#pragma mark - callback
-(void)_clickAvatarCallback:(UIButton*)btn
{
    
}

#pragma mark - set frame
-(void)setMessengerFrame:(GGMessengerFrame *)messageFrame
{
    self.mMessageFrame = messageFrame;
    GGMessenger *pMessage = messageFrame.mMessenger;
    
    /* time */
    self.mLabelTime.text = pMessage.mStrTime;
    self.mLabelTime.frame = messageFrame.mtimeF;
    
    /* avatar */
    self.mAvatarBorder.frame = messageFrame.mIconF;
    self.mBtnAvatar.frame = CGRectMake(2, 2, ChatIconWH-4, ChatIconWH-4);
    if ( pMessage.mMessengerFrom == GGMessengerFromMe)
    {
        [self.mBtnAvatar setBackgroundImage: [UIImage imageNamed:pMessage.mStrIcon]
                                   forState: UIControlStateNormal];
    }
    else
    {
        [self.mBtnAvatar setBackgroundImage: [UIImage imageNamed:pMessage.mStrIcon]
                                   forState: UIControlStateNormal];
    }
    
    /* subcript */
    self.mLabelNumb.text = pMessage.mStrName;
    
    if ( messageFrame.mNameF.origin.x > 160) {
        self.mLabelNumb.frame =
        CGRectMake(messageFrame.mNameF.origin.x - 50, messageFrame.mNameF.origin.y + 3,
                   100, messageFrame.mNameF.size.height);
        self.mLabelNumb.textAlignment = NSTextAlignmentRight;
    }
    else
    {
        self.mLabelNumb.frame =
        CGRectMake( messageFrame.mNameF.origin.x, messageFrame.mNameF.origin.y + 3,
                   80, messageFrame.mNameF.size.height);
        self.mLabelNumb.textAlignment = NSTextAlignmentLeft;
    }
    
    /* content */
    
    //prepare for reuse
    [self.mBtnContent setTitle:@"" forState:UIControlStateNormal];
    self.mBtnContent.frame = messageFrame.mContentF;
    
    if ( pMessage.mMessengerFrom == GGMessengerFromMe)
    {
        [self.mBtnContent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.mBtnContent.contentEdgeInsets = UIEdgeInsetsMake(ChatContentTop, ChatContentRight, ChatContentBottom, ChatContentLeft);
    }
    else
    {
        [self.mBtnContent setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.mBtnContent.contentEdgeInsets = UIEdgeInsetsMake(ChatContentTop, ChatContentLeft, ChatContentBottom, ChatContentRight);
    }
    
    switch ( pMessage.mMessengerType)
    {
        case GGMessengerTypeText:
            [self.mBtnContent setTitle:pMessage.mStrContent
                             forState:UIControlStateNormal];
            break;
        case GGMessengerTypePhoto:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    /* bg content */
    UIImage *normal;
    if (pMessage.mMessengerFrom == GGMessengerFromMe)
    {
        normal = [UIImage imageNamed:@"chatto_bg_normal"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(35, 10, 10, 22)];
    }
    else{
        normal = [UIImage imageNamed:@"chatfrom_bg_normal"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(35, 22, 10, 10)];
    }
    
    [self.mBtnContent setBackgroundImage:normal forState:UIControlStateNormal];
    [self.mBtnContent setBackgroundImage:normal forState:UIControlStateHighlighted];
}

@end
