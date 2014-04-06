HMRIncrementSearchView
======================

HMRIncrementSearchView is a interface for Incremental Search with UITextField and UITableView.

![](https://raw.githubusercontent.com/himaratsu/HMRIncrementSearchView/master/IncrementSearchViewDemo/ScreenShot/screenshot01.png)  
![](https://raw.githubusercontent.com/himaratsu/HMRIncrementSearchView/master/IncrementSearchViewDemo/ScreenShot/screenshot02.png)  


## Requirements

* iOS 5.0 or later
* ARC

## Usage

Instance `HMRIncrementSearchView` and set `HMRIncrementSearchViewDataSource` and `HMRIncrementSearchViewDelegate`.

```
HMRIncrementSearchView *hmrView = [[HMRIncrementSearchView alloc] init];
_hmrView.hmrDataSource = self;
_hmrView.hmrDelegate = self;
[self.view addSubview:_hmrView];
```

And `HMRIncrementSearchView` call dataSource method and delegate method.

##### HMRIncrementSearchViewDataSource

```
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = _sourceArray[indexPath.row];
    
    return cell;
}
```

##### HMRIncrementSearchViewDelegate

```
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didChangeText:(HMRIncrementSearchView *)searchView withText:(NSString *)currentText {
    NSLog(@"currentText[%@]", currentText);
    [self filterContainsWithSearchText:currentText];
    [_hmrView reloadData];
}
```

# Install

## CocoaPods

```
pod 'HMRIncrementSearchView', :git => 'https://github.com/himaratsu/HMRIncrementSearchView'
```

# License

[MIT license.](http://opensource.org/licenses/mit-license.php)




