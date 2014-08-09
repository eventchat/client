//
//  PostBasicCell.m
//  EventChat
//
//  Created by Jianchen Tao on 7/29/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "PostBasicCell.h"

@implementation PostBasicCell{
    BOOL liked;
}

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
    // modify the like cnt
    if (liked) {
        _likeCountLabel.text = [NSString stringWithFormat:@"%li", _likeCountLabel.text.integerValue-1 ];
        liked = NO;
    }else{
        liked = YES;
        _likeCountLabel.text = [NSString stringWithFormat:@"%li", _likeCountLabel.text.integerValue+1 ];
        
    }
    
    id<PostCellDelegate> strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(likeLabelTapOfCell:atIndexPath:likeStatus:)]) {
        [strongDelegate likeLabelTapOfCell:self atIndexPath:[(UITableView *)self.superview.superview indexPathForCell:self] likeStatus:liked];
    }else{
        NSLog(@"like delegate failed");
    }
    
    

}

- (IBAction)commentButtonClicked:(id)sender {
//    [self.delegate likeLabelTapOfCell:self atIndexPath:[(UITableView *)self.superview.superview indexPathForCell:self]];
    id<PostCellDelegate> strongDelegate = self.delegate;
    
    if ([strongDelegate respondsToSelector:@selector(commentLabelTapOfCell:atIndexPath:)]) {
        [strongDelegate commentLabelTapOfCell:self atIndexPath:[(UITableView *)self.superview.superview indexPathForCell:self]];
    }else{
        NSLog(@"comment delegate failed");
    }

}
@end
