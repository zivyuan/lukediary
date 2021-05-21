//
//  LDHistoryView.h
//  LukeDiary
//
//  Created by ziv yuan on 14-7-26.
//  Copyright (c) 2014年 gem design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDHistoryView : UIView
	<UITableViewDataSource>

@property(nonatomic, strong) NSArray                * dataList;
@property(nonatomic, strong) IBOutlet UITableView   * historyTable;

-(void)initial;

@end
