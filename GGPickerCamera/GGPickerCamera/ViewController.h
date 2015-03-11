//
//  ViewController.h
//  GGPickerCamera
//
//  Created by viethq on 2/12/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>

///////////////////////////////////////////////////////

@interface ViewController : UIViewController

//! properties
@property (weak, nonatomic) IBOutlet UIImageView *mImageMedia;
@property (nonatomic, strong) NSURL *mUrlMedia;

//! method
- (IBAction)clickPlayCallback:(id)sender;

//! add in common util
+(UIImage*)thumbnail:(NSURL*)url;
+ (UIImage *)resizeImageWithImage:(UIImage *)image;
+(NSString*)randomStrWith6Char;

@end

