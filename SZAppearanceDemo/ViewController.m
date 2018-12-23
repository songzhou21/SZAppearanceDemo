//
//  ViewController.m
//  SZAppearanceDemo
//
//  Created by songzhou on 2018/12/23.
//  Copyright © 2018 songzhou. All rights reserved.
//

#import "ViewController.h"

@interface SZTableView : UITableView

@end

@implementation SZTableView

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    
}

@end

@interface SZTableViewCell : UITableViewCell

@property (nonatomic) UIColor *contentBackgroundColor UI_APPEARANCE_SELECTOR;

@end


@implementation SZTableViewCell

- (void)setContentBackgroundColor:(UIColor *)contentBackgroundColor {
    self.contentView.backgroundColor = contentBackgroundColor;
}

@end

@interface ViewControllerView : UIView

@property (nonatomic) SZTableView *tableView;

@end

@implementation ViewControllerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _tableView = [[SZTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        [self addSubview:_tableView];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
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
    
    [self.view.tableView registerClass:[SZTableViewCell class] forCellReuseIdentifier:@"c"];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"c"];
    
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self _setupAppearance:indexPath.row != 0];
}

- (void)_setupAppearance:(BOOL)dark {
    
    UIColor *darkGrayColor = UIColor.darkGrayColor;
    UIColor *whiteColor = UIColor.whiteColor;
    
    UIColor *bgColor;
    UIColor *labelColor;
    if (dark) {
        bgColor = darkGrayColor;
        labelColor = whiteColor;
    } else {
        bgColor = whiteColor;
        labelColor = darkGrayColor;
    }
    
    // Appearances
    UITableView *tableViewAppearance = [UITableView appearance];
    SZTableViewCell *tableViewCellAppearance = [SZTableViewCell appearance];
    UILabel *labelInTableViewCell = [UILabel appearanceWhenContainedInInstancesOfClasses:@[SZTableViewCell.class]];
    
    tableViewAppearance.backgroundColor = bgColor;
    tableViewCellAppearance.contentBackgroundColor = bgColor;
    labelInTableViewCell.textColor = labelColor;

    
    /// update appearance
    NSArray *windows = UIApplication.sharedApplication.windows;
    for (UIWindow *window in windows) {
        for (UIView *view in window.subviews) {
            [view removeFromSuperview];
            [window addSubview:view];
        }
    }
}
@end
