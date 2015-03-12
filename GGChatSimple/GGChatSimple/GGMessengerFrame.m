//
//  GGMessengerFrame.m
//  GGChatSimple
//
//  Created by viethq on 2/20/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import "GGMessengerFrame.h"
#import "GGMessenger.h"
#import "GGDefine.h"

@implementation GGMessengerFrame

-(void)setMessenger:(GGMessenger *)messenger
{
    self.mMessenger = messenger;
    
    /* time frame */
    CGFloat timeY = ChatMargin;
    CGRect  txtRec = [self.mMessenger.mStrTime boundingRectWithSize:CGSizeMake( 300.0f, 100.0f)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{ NSFontAttributeName: FONT_CHAT()}
                                                            context:nil];
    
    CGSize timeSize = txtRec.size;
    CGFloat timeX = ( SCREEN_SIZE().width - timeSize.width)*0.5f;
    
    self.mtimeF = CGRectMake( timeX, timeY,
                             timeSize.width + ChatTimeMarginW, timeSize.height + ChatTimeMarginH);
    
    NSLog(@"timeY %f", timeY);
    
    /* avatar  */
    CGFloat iconX = ChatMargin;
    if( self.mMessenger.mMessengerFrom == GGMessengerFromMe)
    {
        iconX = SCREEN_SIZE().width - ChatMargin - ChatIconWH;
    }
    
    CGFloat iconY = CGRectGetMaxY(self.mtimeF) + ChatMargin;
    NSLog(@"iconY %f", iconY);
    self.mIconF = CGRectMake( iconX, iconY, ChatIconWH, ChatIconWH);
    
    /* nick name */
    self.mNameF = CGRectMake(iconX, iconY + ChatIconWH, ChatIconWH, 20);
    
    /* content */
    CGFloat contentX = CGRectGetMaxX(self.mIconF) + ChatMargin;
    CGFloat contentY = iconY;
    
    CGSize contentSize = CGSizeZero;
    switch ( self.mMessenger.mMessengerType)
    {
        case GGMessengerTypeText:
        {
            CGRect  contentRec =
            [self.mMessenger.mStrContent boundingRectWithSize: CGSizeMake( ChatContentW, CGFLOAT_MAX)
                                                      options: NSStringDrawingUsesLineFragmentOrigin
                                                   attributes: @{ NSFontAttributeName: FONT_CONTENT()}
                                                      context: nil];
            contentSize = contentRec.size;
        }
            break;
        case GGMessengerTypePhoto:
            contentSize = CGSizeMake( ChatPicWH, ChatPicWH);
            break;
        default:
            break;
    }
    
    if (self.mMessenger.mMessengerFrom == GGMessengerFromMe)
    {
        contentX = iconX - contentSize.width - ChatContentLeft - ChatContentRight - ChatMargin;
    }
    
    self.mContentF = CGRectMake(contentX, contentY, contentSize.width + ChatContentLeft + ChatContentRight, contentSize.height + ChatContentTop + ChatContentBottom);
    
    /* cell height */
    self.mCellHeight = MAX( CGRectGetMaxY(self.mContentF), CGRectGetMaxY(self.mNameF))  + ChatMargin;
}

@end
