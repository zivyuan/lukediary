//
//  LDHistoryListCellView.h
//  LukeDiary
//
//  Created by ziv yuan on 14-7-26.
//  Copyright (c) 2014年 gem design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDHistoryListCellView : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel * titleLabel;
@property (nonatomic, strong) IBOutlet UILabel * contentLabel;
@property (nonatomic, strong) IBOutlet UILabel * dayLabel;
@property (nonatomic, strong) IBOutlet UILabel * monthLabel;

-(void)setData:(NSDictionary *)data;

@end
