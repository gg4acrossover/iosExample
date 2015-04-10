//
//  ViewController.m
//  GGDropDownMenu
//
//  Created by viethq on 4/7/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import "ViewController.h"

//-------------------------------------------//
static NSString *const CELL_IDENTIFIER = @"CELL_IDENTIFIER";
static CGFloat HEADER_H = 50.0f;
static CGFloat HEADER_ALIGN_LEFT = 10.0f;
static NSString *const IDX_KEY = @"GGTABLEHEADER_KEY";
static NSString *const DELEGATE_KEY = @"DELEGATE_KEY";
//-------------------------------------------//

/////////////////////////////////////////////////////////////////////////////
@implementation UIView(GGTableHeader)

@dynamic mIdx;
@dynamic mDelegate;

-(void)addTapGesture
{
    UITapGestureRecognizer *pTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCallback:)];
    [self addGestureRecognizer:pTap];
}

-(void)tapCallback:(UITapGestureRecognizer*)tapGes
{
    if ( [self.mDelegate respondsToSelector:@selector(eventClickHeaderSection:)])
    {
        NSNumber *pSectionIdx = [NSNumber numberWithInteger:self.mIdx];
        [self.mDelegate performSelector:@selector(eventClickHeaderSection:)
                             withObject:pSectionIdx];
    }
}

-(void)setMIdx:(NSInteger)idx
{
    objc_setAssociatedObject(self, &IDX_KEY, [NSNumber numberWithInteger:idx], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)mIdx
{
    return [objc_getAssociatedObject(self, &IDX_KEY) integerValue];
}

-(void)setMDelegate:(id<GGTableHeaderDelegate>)delegate
{
    objc_setAssociatedObject(self, &DELEGATE_KEY, delegate, OBJC_ASSOCIATION_ASSIGN);
}

-(id<GGTableHeaderDelegate>)mDelegate
{
    return objc_getAssociatedObject(self, &DELEGATE_KEY);
}

@end

/////////////////////////////////////////////////////////////////////////////
@interface ViewController ()<
UITableViewDelegate,
UITableViewDataSource,
GGTableHeaderDelegate>

@property(nonatomic, strong) UITableView *mTblView;
@property(nonatomic, strong) NSArray *mHeaderTitles;
@property(nonatomic, strong) NSArray *mNumberCellInSection;
@property(nonatomic, strong) NSArray *mSectionOpen;

@end

@implementation ViewController

#pragma mark - view life circle
- (void)loadView
{
    [super loadView];
    
    // bg color
    self.view.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //////// SETTING MENU ////////
    self.mHeaderTitles = @[@"first", @"second", @"third"];
    self.mNumberCellInSection = @[@3, @8, @8];
    self.mSectionOpen = @[@0, @0, @0];
    
    self.mTblView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                 style:UITableViewStylePlain];
    [self.view addSubview:self.mTblView];
    self.mTblView.delegate = self;
    self.mTblView.dataSource = self;
}

#pragma mark - tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mHeaderTitles.count;
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return [self.mSectionOpen[section] boolValue] ?
    [self.mNumberCellInSection[section] integerValue] : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEADER_H;
}

-(UIView *)     tableView: (UITableView *)tableView
   viewForHeaderInSection: (NSInteger)section
{
    UIView *pHeaderView =
    [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, HEADER_H)];
    pHeaderView.backgroundColor = [UIColor grayColor];
    
    UILabel *pLabel = [[UILabel alloc] init];
    pLabel.text = self.mHeaderTitles[section];
    pLabel.textColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    [pLabel sizeToFit];
    pLabel.center = CGPointMake( pLabel.center.x + HEADER_ALIGN_LEFT, pHeaderView.center.y);
    [pHeaderView addSubview:pLabel];
    
    // catelogy uiview
    pHeaderView.mIdx = section;
    [pHeaderView addTapGesture];
    pHeaderView.mDelegate = self;
    
    return pHeaderView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView
       cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *pCell = [self.mTblView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if (!pCell)
    {
        pCell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                       reuseIdentifier: CELL_IDENTIFIER];
        pCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    pCell.textLabel.text = [ NSString stringWithFormat:@"row %li",(long)indexPath.row ];
    pCell.imageView.image = [UIImage imageNamed:@"OnLine"];
    return pCell;
}

-(void)         tableView:(UITableView*)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select row");
}

-(void)eventClickHeaderSection:(NSNumber*)section
{
    NSInteger secIdx = [section integerValue];
    NSLog(@"section %li", (long)[section integerValue]);
    NSMutableArray *pArrTempSec = [NSMutableArray arrayWithArray:self.mSectionOpen];
    pArrTempSec[secIdx] = [self.mSectionOpen[secIdx] boolValue] ? @0 : @1;
    self.mSectionOpen = [pArrTempSec copy];
    [self.mTblView reloadSections:[NSIndexSet indexSetWithIndex:secIdx]
                 withRowAnimation: UITableViewRowAnimationFade];
}

@end
