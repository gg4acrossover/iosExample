//
//  GGRootVC.m
//  GGChatSimple
//
//  Created by viethq on 2/18/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import "GGRootVC.h"
#import "GGDefine.h"
#import "GGInputView.h"
#import "GGMessengerCell.h"
#import "GGMessengerFrame.h"
#import "GGMessenger.h"
#import "GGChatModel.h"

@interface GGRootVC ()<
GGInputViewDelegate,
GGMessengerCellDelegate,
UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mTableChat;
@property (nonatomic, strong) GGInputView *mInputView;
@property (nonatomic, strong) GGChatModel *mChatModel;

@end

@implementation GGRootVC

#pragma mark -
#pragma mark view life circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initBar];
    [self _addInputView];
    
    self.mChatModel = [[GGChatModel alloc] init];
    
    self.mTableChat.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.mTableChat.delegate = self;
    self.mTableChat.dataSource = self;
    [self.mTableChat reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //add notification
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(_keyboardChange:)
                                                 name: UIKeyboardWillShowNotification
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(_keyboardChange:)
                                                 name: UIKeyboardWillHideNotification
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(tableViewScrollToBottom)
                                                 name: UIKeyboardDidShowNotification
                                               object: nil];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark add subviews
- (void)_initBar
{
    self.title = @"Simple Chat";
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
}

- (void)_addInputView
{
    self.mInputView = [[GGInputView alloc] initWithSuperView:self];
    self.mInputView.mDelegate = self;
    [self.view addSubview: self.mInputView];
}

#pragma mark -
#pragma mark notify callback
-(void)_keyboardChange:(NSNotification*)notify
{
    NSDictionary *userInfo = [notify userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
        
    // update text input frame
    CGRect newFrame = self.mInputView.frame;
    newFrame.origin.y = keyboardEndFrame.origin.y - newFrame.size.height;
    self.mInputView.frame = newFrame;
    
    [UIView commitAnimations];
}

-(void)tableViewScrollToBottom
{

}

#pragma mark - InputFunctionViewDelegate
- (void)GGInputView:(GGInputView *)inputView sendMessenger:(NSString *)messenger
{
    NSLog(@"mess %@", messenger);
    NSDictionary *dic = @{@"strContent": messenger, @"type":@(GGMessengerTypeText)};
    self.mInputView.mTextInput.text = @"";
    [self dealTheFunctionData:dic];
}

- (void)dealTheFunctionData:(NSDictionary *)dic
{
    [self.mChatModel addSpecialData:dic];
    [self.mTableChat reloadData];
    [self tableViewScrollToBottom];
}

#pragma mark - tableView delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@" cell %li", (long)self.mChatModel.mDataSource.count);
    return self.mChatModel.mDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGMessengerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell == nil)
    {
        cell = [[GGMessengerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        cell.mDelegate = self;
    }
    
    [cell setMessengerFrame:self.mChatModel.mDataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.mChatModel.mDataSource[indexPath.row] mCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

#pragma mark - cellDelegate
- (void)headImageDidClick:(GGMessengerCell *)cell userId:(NSString *)userId
{
    // headIamgeIcon is clicked
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tip" message:@"HeadImageClick !!!" delegate:nil cancelButtonTitle:@"sure" otherButtonTitles:nil];
    [alert show];
}

@end
