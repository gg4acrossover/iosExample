//
//  ViewController.m
//  GGTextLink
//
//  Created by viethq on 2/27/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import "ViewController.h"
#import "TTTAttributedLabel.h"
#import "GGDefine.h"


@interface ViewController ()<TTTAttributedLabelDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TTTAttributedLabel *pLabel =
    [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 80.0f)];
    pLabel.delegate = self;
    
    //1, set text
    NSString *pLabelText = @"操作系统 https://www.google.com/ and http://gamevn.com 操作系统   操作系统";
    
    //2, set attributed for mutil line
    NSMutableAttributedString *pAttributed =
    [[NSMutableAttributedString alloc] initWithString:pLabelText];
    [pAttributed addAttribute:NSFontAttributeName
                  value: pLabel.font
                  range: NSMakeRange(0, pLabelText.length)];
    
    [pLabel setAttributedText:pAttributed];
    
    //3, detect link
    NSDataDetector *pDetectLink = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink
                                                                  error:nil];
    
    NSArray *pArrLink = [pDetectLink matchesInString: pLabelText
                                             options: 0
                                               range: NSMakeRange(0, pLabelText.length)];
    
    for (NSTextCheckingResult *result in pArrLink)
    {
        //4, get all links
        NSString *pLink = [pLabelText substringWithRange:[result range]];
        // NSLog(@"url search in text: %@", [labelText substringWithRange:[result range]]);
        
        //5, label add link
        [pLabel addLinkToURL:[NSURL URLWithString: pLink] withRange:[result range]];
    }
    
    pLabel.lineBreakMode = NSLineBreakByWordWrapping;
    pLabel.numberOfLines = 0;
    
    [self.view addSubview: pLabel];
    pLabel.center = self.view.center;
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    NSLog(@"url in delegate %@", url);
    [[UIApplication sharedApplication] openURL:url];
}

-(CGRect)ADJUST_LABEL_FRAME_HEIGHT: (UILabel*) label
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


@end
