//
//  ViewController.m
//  textfieldTest
//
//  Created by viethq on 2/10/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *mTxtEdit;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mTxtEdit.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *pStrSearch = @"@abc";
    
    if ( self.mTxtEdit.text.length >= pStrSearch.length &&
        range.length == 1 &&
        range.location >= (pStrSearch.length - 1))
    {
        /* check range of text will be removed */
        NSRange rangeToRemove = NSMakeRange( MAX(range.location - (pStrSearch.length - 1), 0),
                                            pStrSearch.length); // lo >= 0
        
        NSString *pStringWillRemove =
        [self.mTxtEdit.text substringWithRange:rangeToRemove];
        
        if ([pStringWillRemove isEqualToString:pStrSearch])
        {
            UITextPosition *pBegin = self.mTxtEdit.beginningOfDocument;
            UITextPosition *pStart = [self.mTxtEdit positionFromPosition: pBegin
                                                                 offset: rangeToRemove.location];
            UITextPosition *pEnd = [self.mTxtEdit positionFromPosition: pStart
                                                                offset: rangeToRemove.length];
            UITextRange *textRange = [self.mTxtEdit textRangeFromPosition: pStart
                                                               toPosition: pEnd];
            
            [self.mTxtEdit replaceRange:textRange withText:@" "];
        }
    }
    
    return TRUE;
}


@end
