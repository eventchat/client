//
//  EventCell.m
//  EventChat
//
//  Created by Jianchen Tao on 7/23/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell
@synthesize eventTitleLabel = _eventTitleLabel;
@synthesize eventTimeLabel = _eventTimeLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
