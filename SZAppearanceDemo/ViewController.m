//
//  ViewController.m
//  SZAppearanceDemo
//
//  Created by songzhou on 2018/12/23.
//  Copyright © 2018 songzhou. All rights reserved.
//

#import "ViewController.h"

@interface ViewControllerView : UIView

@property (nonatomic) UITableView *tableView;

@end

@implementation ViewControllerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        [self addSubview:_tableView];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

@end

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) ViewControllerView *view;

@end

@implementation ViewController

@dynamic view;
- (void)loadView {
    self.view = [ViewControllerView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.tableView.dataSource = self;
    self.view.tableView.delegate = self;
    
    [self.view.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"c"];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"c"];
    
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}
@end
