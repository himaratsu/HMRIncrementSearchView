#import <UIKit/UIKit.h>

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
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;

@end



@interface HMRIncrementSearchView : UIView

@property (nonatomic, assign) id<HMRIncrementSearchViewDataSource> hmrDataSource;
@property (nonatomic, assign) id<HMRIncrementSearchViewDelegate> hmrDelegate;

@property (nonatomic, assign) BOOL isShowTableViewWithNoText;
@property (nonatomic, strong) NSString *textFieldPlaceHolder;

- (void)reloadData;

@end
