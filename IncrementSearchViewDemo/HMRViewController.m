//
//  HMRViewController.m
//  IncrementSearchViewDemo
//
//  Created by himara2 on 2014/04/06.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "HMRViewController.h"
#import "HMRIncrementSearchView.h"

@interface HMRViewController ()
<HMRIncrementSearchViewDataSource, HMRIncrementSearchViewDelegate>

@property (nonatomic) HMRIncrementSearchView *hmrView;

@property (nonatomic, copy) NSArray *sourceArray;
@property (nonatomic, strong) NSArray *filterdArray;

@end


@implementation HMRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sourceArray = @[@"himara2", @"rhiramat", @"hunishi", @"tshiino"];
    
    self.hmrView = [[HMRIncrementSearchView alloc] init];
    _hmrView.hmrDataSource = self;
    _hmrView.hmrDelegate = self;
    [self.view addSubview:_hmrView];
}


#pragma mark - HMRIncrementSearchViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_filterdArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSectionWithoutData:(NSInteger)section {
    return [_sourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        // 再利用できない場合は新規で作成
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = _filterdArray[indexPath.row];
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPathWithoutData:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"NoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        // 再利用できない場合は新規で作成
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = _sourceArray[indexPath.row];
    
    return cell;
}

#pragma mark - HMRIncrementSearchViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didChangeText:(HMRIncrementSearchView *)searchView withText:(NSString *)currentText {
    NSLog(@"currentText[%@]", currentText);
    [self filterContainsWithSearchText:currentText];
    [_hmrView reloadData];
}



- (void)filterContainsWithSearchText:(NSString *)searchText
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    
    self.filterdArray = [self.sourceArray filteredArrayUsingPredicate:predicate];
}

@end
