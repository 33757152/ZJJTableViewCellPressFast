//
//  ViewController.m
//  ZJJTableViewCellPressFast
//
//  Created by xtayqria on 2019/2/14.
//  Copyright © 2019年 xtayqria. All rights reserved.
//

#import "ViewController.h"
#import "PushViewController.h"
#import "UIView+TableViewCellSelectedOnce.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    UIImageView *_headImageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"PressFast";
    [self creatTable];
}

- (void)creatTable {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    
    UIImageView *head = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, 0, 100, 100)];
    head.image = [UIImage imageNamed:@"1.jpeg"];
    head.layer.cornerRadius = 50.0f;
    head.clipsToBounds = true;
    [tableView addSubview:head];
    _headImageView = head;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view tableView:tableView didSelectRowAtIndexPath:indexPath selectedResultBlock:^(NSIndexPath *lastIndexPath) {
        PushViewController *push = [[PushViewController alloc] init];
        push.navigationItem.title = [NSString stringWithFormat:@"%ld",indexPath.row];
        [self.navigationController pushViewController:push animated:YES];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset_y = scrollView.contentOffset.y;
    if (offset_y < -64) {
        // 向下偏
        _headImageView.center = CGPointMake(self.view.center.x, 50+(offset_y+64)/2);
        _headImageView.bounds = CGRectMake(0, 0, 100-0.8*(offset_y+64), 100-0.8*(offset_y+64));
        _headImageView.layer.cornerRadius = _headImageView.bounds.size.width/2;
        _headImageView.clipsToBounds = YES;
    } else {
        // 向上偏
    }
}

@end
