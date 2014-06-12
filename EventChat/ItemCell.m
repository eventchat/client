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

@synthesize likePost = _likePost;

@synthesize morePost = _morePost;

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


// affects the size of the label when layout constraints are applied to ti. During layout, if the text extends beyond the width specified by this property, the additional text is flowed to one or more anew lines, thereby increasing the height of the label.
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView layoutIfNeeded];
    self.msgImage.contentMode = UIViewContentModeScaleAspectFit;
//    self.msgImage.frame = CGRectMake(self.msgImage.frame.origin.x, self.msgImage.frame.origin.y, 100, 100);
    self.msgText.preferredMaxLayoutWidth = CGRectGetWidth(self.msgText.frame);
    
}

@end
