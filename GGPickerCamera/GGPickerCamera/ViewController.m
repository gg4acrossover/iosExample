//
//  ViewController.m
//  GGPickerCamera
//
//  Created by viethq on 2/12/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import "ViewController.h"

static CGFloat const MAX_SIZE_IMAGE_HEIGHT = 240.0f;
static CGFloat const MAX_SIZE_IMAGE_WIDTH = 320.0f;
static NSString *const DATEFORMAT_YYYYMMDD = @"yyyyMMddHHmmss";

//////////////////////////////////////

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (IBAction)clickCameraCallback:(id)sender;

@end

@implementation ViewController

#pragma mark - view life circle
- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - picker delegate
- (void)    imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *pMediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:FALSE completion:nil];
    
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef) pMediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
    {
        // 1, create path for saving video
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *outputURL = paths[0];
        
        
        // 2, remove file existing
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager createDirectoryAtPath: outputURL
           withIntermediateDirectories: YES
                            attributes: nil
                                 error: nil];
        
        outputURL = [outputURL stringByAppendingPathComponent:@"output.mov"];
        NSLog(@" output %@", outputURL);
        
        [manager removeItemAtPath:outputURL error:nil];

        
        // 3, create export fiel
        AVAsset *pVideo = [AVAsset assetWithURL: info[UIImagePickerControllerMediaURL]];
        AVAssetExportSession *pExport =
        [[AVAssetExportSession alloc] initWithAsset: pVideo
                                         presetName: AVAssetExportPresetPassthrough];
        
        
        // 4, setting export video
        pExport.outputURL = [NSURL fileURLWithPath:outputURL];
        pExport.outputFileType = AVFileTypeMPEG4;
        pExport.shouldOptimizeForNetworkUse = TRUE;
        
        __weak NSString *pUrl = outputURL;
        
        [pExport exportAsynchronouslyWithCompletionHandler:^{
            
            if ( [pExport status] == AVAssetExportSessionStatusCompleted)
            {
                // 5, save video
                UISaveVideoAtPathToSavedPhotosAlbum(pUrl, self, nil, nil);
            }
            else
            {
                // fail
            }
            
        }];
    }
}

#pragma mark - btn callback
- (IBAction)clickCameraCallback:(id)sender
{
    UIImagePickerController *pPicker = [[UIImagePickerController alloc] init];
    
    // setting picker view
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        pPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        pPicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        pPicker.allowsEditing = TRUE;
        pPicker.delegate = self;
        pPicker.videoQuality = UIImagePickerControllerQualityType640x480;
        pPicker.videoMaximumDuration = 90.0f;
        
        [self presentViewController:pPicker animated:YES completion:nil];
    }
}


- (IBAction)clickPlayCallback:(id)sender
{
    if ( !self.mUrlMedia) {
        return;
    }
    
    MPMoviePlayerViewController* moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL: self.mUrlMedia];
    [self presentMoviePlayerViewControllerAnimated:moviePlayerController];
    [moviePlayerController.moviePlayer prepareToPlay];
    moviePlayerController.moviePlayer.shouldAutoplay=YES;
    [moviePlayerController.moviePlayer play];
}

#pragma mark - image setting
+(UIImage*)thumbnail:(NSURL*)url
{
    AVAsset *asset = [AVAsset assetWithURL:url];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    CMTime time = [asset duration];
    time.value = 0;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);  // CGImageRef won't be released by ARC
    
    return thumbnail;

}

+ (UIImage *)resizeImageWithImage:(UIImage *)image{
    
    float imageHeight = image.size.height;
    float imageWidth = image.size.width;
    
    CGSize newSize;
    if (imageHeight > imageWidth) {
        newSize.height = MAX_SIZE_IMAGE_HEIGHT;
        newSize.width = (imageWidth * newSize.height )/imageHeight;
    }else{
        newSize.width = MAX_SIZE_IMAGE_WIDTH;
        newSize.height = (imageHeight * newSize.width )/imageWidth;
    }
    
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(NSString*)getStringNameDateWithFormat:(NSString*) format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    return dateString;

}

@end
