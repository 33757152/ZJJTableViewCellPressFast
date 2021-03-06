//
//  UIView+TableViewCellSelectedOnce.h
//  ZJJTableViewCellPressFast
//
//  Created by xtayqria on 2019/2/14.
//  Copyright © 2019年 xtayqria. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TableViewCellSelectedOnce)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath selectedResultBlock:(void(^)(NSIndexPath *lastIndexPath))indexBlock;

@end

NS_ASSUME_NONNULL_END
