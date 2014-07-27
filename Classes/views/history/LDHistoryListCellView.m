//
//  LDHistoryListCellView.m
//  LukeDiary
//
//  Created by ziv yuan on 14-7-26.
//  Copyright (c) 2014年 gem design. All rights reserved.
//

#import "LDHistoryListCellView.h"

@implementation LDHistoryListCellView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.backgroundView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary *)data
{
	self.titleLabel.text = [data objectForKey:@"title"];
	self.contentLabel.text = [data objectForKey:@"content"];
	NSString * datestr = [NSString stringWithFormat:@"%@", [data objectForKey:@"date"]];
	NSRange range;
	range.location = 8;
	range.length = 2;
	self.dayLabel.text = [datestr substringWithRange:range];
	NSRange mrange;
	mrange.location = 5;
	mrange.length = 2;
	self.monthLabel.text = [datestr substringWithRange:mrange];
}

@end
