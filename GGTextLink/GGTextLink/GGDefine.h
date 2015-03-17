//
//  GGDefine.h
//  GGChatSimple
//
//  Created by viethq on 2/18/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#ifndef GGChatSimple_GGDefine_h
#define GGChatSimple_GGDefine_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//! define macro


//! rec method
CGFloat ORIGIN_X( CGRect rec);
CGFloat ORIGIN_Y( CGRect rec);
CGRect CHANGE_ORIGIN_X( CGRect rec, CGFloat originX);
CGRect CHANGE_ORIGIN_Y( CGRect rec, CGFloat originY);
CGRect CHANGE_ORIGIN( CGRect rec, CGFloat originX, CGFloat originY);
CGRect CHANGE_W( CGRect rec, CGFloat w);
CGRect CHANGE_H( CGRect rec, CGFloat h);
CGRect CHANGE_SIZE( CGRect rec, CGFloat w, CGFloat h);

//! screen w,h
CGSize SCREEN_SIZE();

//! font
UIFont *FONT_SYS(CGFloat size);
CGRect ADJUST_LABEL_FRAME_HEIGHT(UILabel*label);

//! date
NSString *CURRENT_TIME( NSString* format);

//! project config
UIFont *FONT_CHAT();
UIFont *FONT_CONTENT();

//! extern string format
FOUNDATION_EXTERN NSString *const DD_MM_YY;
FOUNDATION_EXTERN NSString *const FULL_TIME;

#endif
