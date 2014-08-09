//
//  PostBasicCell.m
//  EventChat
//
//  Created by Jianchen Tao on 7/29/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "PostBasicCell.h"

@implementation PostBasicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)likeButtonClicked:(id)sender {
//    [self.delegate commentLabelTapOfCell:self atIndexPath:[(UITableView *)self.superview.superview indexPathForCell:self]];
    NSLog(@"I am in basic cell like button!");
}

- (IBAction)commentButtonClicked:(id)sender {
//    [self.delegate likeLabelTapOfCell:self atIndexPath:[(UITableView *)self.superview.superview indexPathForCell:self]];
        NSLog(@"I am in basic cell comment button!");
}
@end
