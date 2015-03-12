//
//  GGMessenger.m
//  GGChatSimple
//
//  Created by viethq on 2/20/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import "GGMessenger.h"

@implementation GGMessenger

-(void)setWithDict:(NSDictionary *)dict
{
    self.mStrIcon = dict[@"strIcon"];
    self.mStrName = dict[@"strName"];
    self.mStrUId = dict[@"strUId"];
    self.mStrTime = @"today";
    
    if ( [[dict valueForKey:@"from"] integerValue] == 1)
    {
        self.mMessengerFrom = GGMessengerFromMe;
    }
    else
    {
        self.mMessengerFrom = GGMessengerFromFriend;
    }
    
    switch ([dict[@"type"] integerValue])
    {
            
        case GGMessengerTypeText:
            self.mMessengerType = GGMessengerTypeText;
            self.mStrContent = dict[@"strContent"];
            break;
            
        case GGMessengerTypePhoto:
            self.mMessengerType = GGMessengerTypePhoto;
            self.mPic = dict[@"picture"];
            break;
    
        default:
            break;
    }
}

@end
