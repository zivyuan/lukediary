//
//  LDHistoryView.m
//  LukeDiary
//
//  Created by ziv yuan on 14-7-26.
//  Copyright (c) 2014年 gem design. All rights reserved.
//

#import "LDHistoryView.h"
#import "LDHistoryListCellView.h"

@implementation LDHistoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initial
{
	self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-bottom"]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - History Table Data Source & Delegate
-(void)setDataList:(NSArray *)dataList
{
	_dataList = dataList;
    self.historyTable.rowHeight = 80;
	[self.historyTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.dataList ? [self.dataList count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * identifier = @"HistoryListCellView";
	LDHistoryListCellView * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	NSDictionary * dict = [self.dataList objectAtIndex:[indexPath indexAtPosition:1]];
	[cell setData:dict];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

@end
