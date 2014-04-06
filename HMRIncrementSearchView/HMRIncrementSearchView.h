//
//  HMRIncrementSearchView.h
//  HMRIncrementSearchView
//
//  Created by himara2 on 2014/04/06.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class HMRIncrementSearchView;


@protocol HMRIncrementSearchViewDataSource <NSObject>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSectionWithoutData:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPathWithoutData:(NSIndexPath *)indexPath;

@end

@protocol HMRIncrementSearchViewDelegate <NSObject>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)didChangeText:(HMRIncrementSearchView *)searchView withText:(NSString *)currentText;

@end



@interface HMRIncrementSearchView : UIView

@property (nonatomic, assign) id<HMRIncrementSearchViewDataSource> hmrDataSource;
@property (nonatomic, assign) id<HMRIncrementSearchViewDelegate> hmrDelegate;

@property (nonatomic, assign) BOOL isShowTableViewWithNoText;

- (void)reloadData;

@end
