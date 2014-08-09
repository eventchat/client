//
//  PostBasicCell.h
//  EventChat
//
//  Created by Jianchen Tao on 7/29/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PostCellDataSource, PostCellDelegate;

@interface PostBasicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *likeButtonImageView;
@property (weak, nonatomic) IBOutlet UIImageView *commentButtonImageView;

- (IBAction)likeButtonClicked:(id)sender;
- (IBAction)commentButtonClicked:(id)sender;


@property (nonatomic, weak) id <PostCellDataSource> dataSource;
@property (nonatomic, weak) id <PostCellDelegate> delegate;

@end

@protocol PostCellDelegate <NSObject>
@optional
- (void)commentLabelTapOfCell:(PostBasicCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)likeLabelTapOfCell:(PostBasicCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end