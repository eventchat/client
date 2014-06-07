//
//  TweetCell.m
//  EventChat
//
//  Created by Jianchen Tao on 6/7/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

@synthesize userImage = _userImage;

@synthesize msgImage = _msgImage;

@synthesize userName = _userName;

@synthesize msgTime = _msgTime;

@synthesize msgText = _msgText;

@synthesize msgLocation = _msgLocation;

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
