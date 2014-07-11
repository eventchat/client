//
//  ChatMessageCell.h
//  EventChat
//
//  Created by Jianchen Tao on 7/8/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatMessageCellDataSource, ChatMessageCellDelegate;

extern const CGFloat ChatMessageCellBubbleWidthOffset; // Extra width added to bubble
extern const CGFloat ChatMessageCellBubbleImageSize; // The size of the image

typedef NS_ENUM(NSUInteger, AuthorType) {
	ChatMessageCellAuthorTypeSelf = 0,
	ChatMessageCellAuthorTypeOther
};

typedef NS_ENUM(NSUInteger, BubbleColor) {
	ChatMessageCellBubbleColorGreen = 0,
	ChatMessageCellBubbleColorGray = 1,
	ChatMessageCellBubbleColorAqua = 2, // Default value of selectedBubbleColor
	ChatMessageCellBubbleColorBrown = 3,
	ChatMessageCellBubbleColorGraphite = 4,
	ChatMessageCellBubbleColorOrange = 5,
	ChatMessageCellBubbleColorPink = 6,
	ChatMessageCellBubbleColorPurple = 7,
    ChatMessageCellBubbleColorRed = 8,
	ChatMessageCellBubbleColorYellow = 9
};

@interface ChatMessageCell : UITableViewCell

@property (nonatomic, strong, readonly) UIImageView *bubbleView;
@property (nonatomic, assign) AuthorType authorType;
@property (nonatomic, assign) BubbleColor bubbleColor;
@property (nonatomic, assign) BubbleColor selectedBubbleColor;
@property (nonatomic, assign) BOOL canCopyContents; // Defaults to YES
@property (nonatomic, assign) BOOL selectionAdjustsColor; // Defaults to YES
@property (nonatomic, weak) id <ChatMessageCellDataSource> dataSource;
@property (nonatomic, weak) id <ChatMessageCellDelegate> delegate;

@end

@protocol ChatMessageCellDataSource <NSObject>
@optional
- (CGFloat)minInsetForCell:(ChatMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@protocol ChatMessageCellDelegate <NSObject>
@optional
- (void)tappedImageOfCell:(ChatMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end