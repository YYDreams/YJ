//
//  HomeViewController.m
//  YJ
//
//  Created by flowerflower on 2021/5/22.
//

#import "HomeViewController.h"
#import "HomeCell.h"
@interface HomeViewController ()

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource =self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = [UIView new];
        _tableView.separatorColor = [UIColor colorWithHex:0xDCE0E4];
        _tableView.tableFooterView.height = 40;
        _tableView.backgroundColor = [UIColor colorWithHex:0xF0F2F4];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            if (@available(iOS 11.0, *)) {
                _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
        
    }
    return _tableView;
}

@end
