//
//  TempCell.m
//  EventChat
//
//  Created by Jianchen Tao on 7/25/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "TempCell.h"

@implementation TempCell

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

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self._avatarImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

@end
