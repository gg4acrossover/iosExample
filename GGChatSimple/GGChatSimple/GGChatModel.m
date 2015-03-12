//
//  GGChatModel.m
//  GGChatSimple
//
//  Created by viethq on 2/20/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import "GGChatModel.h"
#import "GGMessenger.h"
#import "GGMessengerFrame.h"

@implementation GGChatModel

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.mDataSource = [[NSMutableArray alloc] initWithCapacity:50];
    }
    
    return  self;
}

-(void)addSpecialData:(NSDictionary *)dict
{
    GGMessengerFrame *messageFrame = [[GGMessengerFrame alloc]init];
    GGMessenger *message = [[GGMessenger alloc] init];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    [dataDic setObject:@1 forKey:@"from"];
    [dataDic setObject:[[NSDate date] description] forKey:@"strTime"];
    [dataDic setObject:@"Hello,sister" forKey:@"strName"];
    [dataDic setObject:@"chat_voice_record" forKey:@"strIcon"];
    
    [message setWithDict:dataDic];
    messageFrame.mIsShowTime = message.mIsShowDateLabel;
    [messageFrame setMessenger:message];
    
    [self.mDataSource addObject:messageFrame];
}

@end
