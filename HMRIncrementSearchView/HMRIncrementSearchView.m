#import "HMRIncrementSearchView.h"

static const NSInteger HMRTextFieldHeight = 30;

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
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(self.bounds.origin.x,
                                                                   self.bounds.origin.y,
                                                                   self.bounds.size.width,
                                                                   HMRTextFieldHeight)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.delegate = self;
    [self addSubview:_textField];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.bounds.origin.x,
                                                                   HMRTextFieldHeight,
                                                                   self.bounds.size.width,
                                                                   self.bounds.size.height - HMRTextFieldHeight)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addSubview:_tableView];
    
    _isShowTableViewWithNoText = NO;
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
        _tableView.hidden = NO;
        if (rows == 0) {
            if ([_hmrDataSource respondsToSelector:@selector(tableView:numberOfRowsInSectionWithoutData:)]) {
                rows = [_hmrDataSource tableView:tableView numberOfRowsInSectionWithoutData:section];
            }
            _tableView.hidden = !_isShowTableViewWithNoText;
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
    // 現在のテキストフィールドの値を取得
    NSString *inputText = @"";
    if (string == nil || [string isEqual:@""]) {
        NSMutableString *tmpText = [_textField.text mutableCopy];
        [tmpText replaceCharactersInRange:range withString:@""];
        
        inputText = [tmpText copy];
    }
    else {
        inputText = [NSString stringWithFormat:@"%@%@", _textField.text, string];
    }
    
    if ([_hmrDelegate respondsToSelector:@selector(didChangeText:withText:)]) {
        [_hmrDelegate didChangeText:self withText:inputText];
    }
        
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _tableView.hidden = NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _tableView.hidden = !_isShowTableViewWithNoText;
}

@end
