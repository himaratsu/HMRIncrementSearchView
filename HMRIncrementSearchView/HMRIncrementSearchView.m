//
//  HMRIncrementSearchView.m
//  HMRIncrementSearchView
//
//  Created by himara2 on 2014/04/06.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "HMRIncrementSearchView.h"

@interface HMRIncrementSearchView ()
<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UITextField *textField;

@end

@implementation HMRIncrementSearchView

- (id)init
{
    return [self initWithFrame:[UIScreen mainScreen].applicationFrame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    _textField.borderStyle = UITextBorderStyleLine;
    _textField.delegate = self;
    [self addSubview:_textField];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 20)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addSubview:_tableView];
    
}

- (void)reloadData {
    [_tableView reloadData];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_hmrDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [_hmrDataSource numberOfSectionsInTableView:tableView];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_hmrDataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        NSInteger rows = [_hmrDataSource tableView:tableView numberOfRowsInSection:section];

        if (rows == 0) {
            if ([_hmrDataSource respondsToSelector:@selector(tableView:numberOfRowsInSectionWithoutData:)]) {
                rows = [_hmrDataSource tableView:tableView numberOfRowsInSectionWithoutData:section];
            }
        }
        return rows;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rows = 0;
    if ([_hmrDataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
         rows = [_hmrDataSource tableView:tableView numberOfRowsInSection:indexPath.section];
    }
    
    if (rows == 0) {
        if ([_hmrDataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPathWithoutData:)]) {
            return [_hmrDataSource tableView:tableView cellForRowAtIndexPathWithoutData:indexPath];
        }
    }
    else {
        if ([_hmrDataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
            return [_hmrDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_hmrDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_hmrDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    // TODO: 厳密に現在の文字列を取得するよう変更する
    NSString *inputString = _textField.text;
    
    // 変更があったことを通知して新しいリストを取得
    if ([_hmrDelegate respondsToSelector:@selector(didChangeText:withText:)]) {
        [_hmrDelegate didChangeText:self withText:inputString];
    }
        
    return YES;
}

@end
