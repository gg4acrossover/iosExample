//
//  GGChatModel.h
//  GGChatSimple
//
//  Created by viethq on 2/20/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGChatModel : NSObject

@property(nonatomic, strong) NSMutableArray *mDataSource;

-(void)addSpecialData:(NSDictionary*)dict;

@end
