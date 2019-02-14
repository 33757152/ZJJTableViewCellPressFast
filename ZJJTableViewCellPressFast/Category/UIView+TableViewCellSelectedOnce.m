//
//  UIView+TableViewCellSelectedOnce.m
//  ZJJTableViewCellPressFast
//
//  Created by xtayqria on 2019/2/14.
//  Copyright © 2019年 xtayqria. All rights reserved.
//

#import "UIView+TableViewCellSelectedOnce.h"
#import <objc/runtime.h>

typedef void(^indexResult)(NSIndexPath *);

@interface UIView ()

@property (nonatomic, copy) indexResult selectedIndexBlock;

@end

static const char *selectedIndexBlockKey = "selectedIndexBlockKey";

@implementation UIView (TableViewCellSelectedOnce)

- (void)setSelectedIndexBlock:(indexResult)selectedIndexBlock {
    objc_setAssociatedObject(self, selectedIndexBlockKey, selectedIndexBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (indexResult)selectedIndexBlock {
    return objc_getAssociatedObject(self, selectedIndexBlockKey);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath selectedResultBlock:(void(^)(NSIndexPath *lastIndexPath))indexBlock {
    self.selectedIndexBlock = indexBlock;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    NSDictionary *objectDic = @{@"tableView":tableView,@"indexPath":indexPath};
    [self performSelector:@selector(selectRowDelay:) withObject:objectDic afterDelay:0.01];
}

- (void)selectRowDelay:(NSDictionary *)dict {
    UITableView *tableView = [dict objectForKey:@"tableView"];
    NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    __block UIView *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cell.selected = false;
        if (weakSelf.selectedIndexBlock) {
            weakSelf.selectedIndexBlock(indexPath);
        }
    });
}

@end
