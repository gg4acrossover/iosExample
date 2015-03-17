//
//  GGDefine.m
//  GGChatSimple
//
//  Created by viethq on 2/18/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import "GGDefine.h"

/*
 * rec method
 */

CGFloat ORIGIN_X( CGRect rec)
{
    return rec.origin.x;
}

CGFloat ORIGIN_Y( CGRect rec)
{
    return rec.origin.y;
}

CGRect CHANGE_ORIGIN_X( CGRect rec, CGFloat originX)
{
    return CGRectMake( originX, rec.origin.y, rec.size.width, rec.size.height);
}

CGRect CHANGE_ORIGIN_Y( CGRect rec, CGFloat originY)
{
    return CGRectMake( rec.origin.x, rec.origin.y, rec.size.width, rec.size.height);
}

CGRect CHANGE_ORIGIN( CGRect rec, CGFloat originX, CGFloat originY)
{
    return CGRectMake( originX, originY, rec.size.width, rec.size.height);
}

CGRect CHANGE_W( CGRect rec, CGFloat w)
{
    return CGRectMake( rec.origin.x, rec.origin.y, w, rec.size.height);
}

CGRect CHANGE_H( CGRect rec, CGFloat h)
{
    return CGRectMake( rec.origin.x, rec.origin.y, rec.size.width, h);
}

CGRect CHANGE_SIZE( CGRect rec, CGFloat w, CGFloat h)
{
    return CGRectMake(rec.origin.x, rec.origin.y, w, h);
}

/*
 * screen size
 */

CGSize SCREEN_SIZE()
{
    return CGSizeMake( [UIScreen mainScreen].bounds.size.width,
                      [UIScreen mainScreen].bounds.size.height );
}

/*
 * font
 */

UIFont *FONT_SYS(CGFloat size)
{
    return [UIFont systemFontOfSize:size];
}

CGRect ADJUST_LABEL_FRAME_HEIGHT( UILabel* label)
{
    CGRect recLabel = label.frame;
    CGSize sizeTxt = CGSizeMake( label.frame.size.width, FLT_MAX);
    CGRect rec = [label.text boundingRectWithSize: sizeTxt
                                          options: NSStringDrawingUsesLineFragmentOrigin
                                       attributes: @{ NSFontAttributeName: label.font}
                                          context: nil];
    recLabel.size.height = rec.size.height;
    
    return recLabel;
}

/*
 * date format
 */

NSString *CURRENT_TIME( NSString* format)
{
    NSDateFormatter *pDateFormat = [[NSDateFormatter alloc] init];
    pDateFormat.dateFormat = format;
    
    return [pDateFormat stringFromDate:[NSDate date]];
}

/*
 * project
 */

UIFont *FONT_CHAT() { return FONT_SYS(11); };
UIFont *FONT_CONTENT() { return FONT_SYS(14); };

// date format
NSString *const DD_MM_YY = @"dd-MM-yyyy";
NSString *const FULL_TIME = @"yyyyMMddHHmmss";
