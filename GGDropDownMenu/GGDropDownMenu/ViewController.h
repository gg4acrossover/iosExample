//
//  ViewController.h
//  GGDropDownMenu
//
//  Created by viethq on 4/7/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@protocol  GGTableHeaderDelegate<NSObject>

-(void)eventClickHeaderSection:(NSNumber*)section;

@end

@interface UIView(GGTableHeader)

@property(nonatomic, assign) NSInteger mIdx;
@property(nonatomic, weak) id<GGTableHeaderDelegate> mDelegate;
-(void)addTapGesture;

@end

@interface ViewController : UIViewController

@end

