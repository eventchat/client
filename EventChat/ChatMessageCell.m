//
//  ChatMessageCell.m
//  EventChat
//
//  Created by Jianchen Tao on 7/8/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "ChatMessageCell.h"
#import <QuartzCore/QuartzCore.h>

const CGFloat ChatMessageCellBubbleWidthOffset = 35.0f;
const CGFloat ChatMessageCellBubbleImageSize = 50.0f;

@implementation ChatMessageCell
@synthesize bubbleView = _bubbleView;


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
        _bubbleView= [[UIImageView alloc] initWithFrame:CGRectZero];
        _bubbleView.userInteractionEnabled = YES;
        [self.contentView addSubview:_bubbleView];
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.numberOfLines = 0;
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.font = [UIFont systemFontOfSize:14.0];
        
        self.imageView.userInteractionEnabled = YES;
        self.imageView.layer.cornerRadius = 5.0;
        self.imageView.layer.masksToBounds = YES;
        
        UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [_bubbleView addGestureRecognizer:longPressRecognizer];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self.imageView addGestureRecognizer:tapRecognizer];
        
        // Defaults
        _selectedBubbleColor = ChatMessageCellBubbleColorAqua;
        _canCopyContents = YES;
        _selectionAdjustsColor = YES;
        
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _bubbleView= [[UIImageView alloc] initWithFrame:CGRectZero];
        _bubbleView.userInteractionEnabled = YES;
        [self.contentView addSubview:_bubbleView];
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.numberOfLines = 0;
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.font = [UIFont systemFontOfSize:14.0];
        
        self.imageView.userInteractionEnabled = YES;
        self.imageView.layer.cornerRadius = 5.0;
        self.imageView.layer.masksToBounds = YES;
        
        UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [_bubbleView addGestureRecognizer:longPressRecognizer];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self.imageView addGestureRecognizer:tapRecognizer];
        
        // Defaults
        _selectedBubbleColor = ChatMessageCellBubbleColorAqua;
        _canCopyContents = YES;
        _selectionAdjustsColor = YES;
        
    }
    return self;
}

- (void)updateFramesForAuthorType:(AuthorType)type {
    [self setImageForBubbleColor:self.bubbleColor];

    CGFloat minInset = 0.0f;
    if ([self.dataSource respondsToSelector:@selector(minInsetForCell:atIndexPath:)]) {
        minInset = [self.dataSource minInsetForCell:self atIndexPath:[[self tableView] indexPathForCell:self]];
    }
    
    CGSize size;
    if (self.imageView.image) {

//        size = [self.textLabel.text sizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(self.frame.size.width - minInset - ChatMessageBubbleWidthOffset - ChatMessageBubbleImageSize - 8.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGRect rect = [self.textLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width - minInset - ChatMessageCellBubbleWidthOffset -  ChatMessageCellBubbleImageSize - 8.0f, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:self.textLabel.font} context:nil];
        size = rect.size;
    } else {
//        size = [self.textLabel.text sizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(self.frame.size.width - minInset - ChatMessageBubbleWidthOffset, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGRect rect = [self.textLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width - minInset - ChatMessageCellBubbleWidthOffset, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: self.textLabel.font} context:nil];
        size = rect.size;
    }
    
    if (type == ChatMessageCellAuthorTypeSelf) {
        if (self.imageView.image) {
            self.bubbleView.frame = CGRectMake(self.frame.size.width - (size.width + ChatMessageCellBubbleWidthOffset) - ChatMessageCellBubbleImageSize - 8.0f, self.frame.size.height - (size.height + 15.0f), size.width + ChatMessageCellBubbleWidthOffset, size.height + 15.0f);
            self.imageView.frame = CGRectMake(self.frame.size.width - ChatMessageCellBubbleImageSize - 5.0f, self.frame.size.height - ChatMessageCellBubbleImageSize - 2.0f, ChatMessageCellBubbleImageSize, ChatMessageCellBubbleImageSize);
            self.textLabel.frame = CGRectMake(self.frame.size.width - (size.width + ChatMessageCellBubbleWidthOffset - 10.0f) - ChatMessageCellBubbleImageSize - 8.0f, self.frame.size.height - (size.height + 15.0f) + 6.0f, size.width + ChatMessageCellBubbleWidthOffset - 23.0f, size.height);
        }
        else {
            self.bubbleView.frame = CGRectMake(self.frame.size.width - (size.width + ChatMessageCellBubbleWidthOffset), 0.0f, size.width + ChatMessageCellBubbleWidthOffset, size.height + 15.0f);
            self.imageView.frame = CGRectZero;
            self.textLabel.frame = CGRectMake(self.frame.size.width - (size.width + ChatMessageCellBubbleWidthOffset - 10.0f), 6.0f, size.width + ChatMessageCellBubbleWidthOffset - 23.0f, size.height);
        }
        
        self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        self.bubbleView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        self.bubbleView.transform = CGAffineTransformIdentity;
    }
    else {
        if (self.imageView.image) {
            self.bubbleView.frame = CGRectMake(ChatMessageCellBubbleImageSize + 8.0f, self.frame.size.height - (size.height + 15.0f), size.width + ChatMessageCellBubbleWidthOffset, size.height + 15.0f);
            self.imageView.frame = CGRectMake(5.0f, self.frame.size.height - ChatMessageCellBubbleImageSize - 2.0f, ChatMessageCellBubbleImageSize, ChatMessageCellBubbleImageSize);
            self.textLabel.frame = CGRectMake(ChatMessageCellBubbleImageSize + 8.0f + 16.0f, self.frame.size.height - (size.height + 15.0f) + 6.0f, size.width + ChatMessageCellBubbleWidthOffset - 23.0f, size.height);
        }
        else {
            self.bubbleView.frame = CGRectMake(0.0f, 0.0f, size.width + ChatMessageCellBubbleWidthOffset, size.height + 15.0f);
            self.imageView.frame = CGRectZero;
            self.textLabel.frame = CGRectMake(16.0f, 6.0f, size.width + ChatMessageCellBubbleWidthOffset - 23.0f, size.height);
        }
        
        self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        self.bubbleView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        self.bubbleView.transform = CGAffineTransformIdentity;
        self.bubbleView.transform = CGAffineTransformMakeScale(-1.0f, 1.0f);
    }
    
}

- (void)setImageForBubbleColor:(BubbleColor)color {
    self.bubbleView.image = [[UIImage imageNamed:[NSString stringWithFormat:@"Bubble-%i", color]] resizableImageWithCapInsets:UIEdgeInsetsMake(12.0f, 15.0f, 16.0f, 18.0f)];
}

- (void)layoutSubviews {
    [self updateFramesForAuthorType:self.authorType];
}


- (UITableView *)tableView {
    UIView *tableView = self.superview;
    
    while(tableView) {
        if ([tableView isKindOfClass:[UITableView class]]) {
            return (UITableView *)tableView;
        }
        
        tableView = tableView.superview;
    }
    
    return nil;
}

#pragma mark - Setters

- (void)setBubbleColor:(BubbleColor)color {
    _bubbleColor = color;
    [self setImageForBubbleColor:_bubbleColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



#pragma mark - UIGestureRecognizer methods

- (void)longPress: (UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
        if (self.canCopyContents) {
            UIMenuController *menuController = [UIMenuController sharedMenuController];
            [self becomeFirstResponder];
            [menuController setTargetRect:self.bubbleView.frame inView:self];
            [menuController setMenuVisible:YES animated:YES];
            
            if (self.selectionAdjustsColor) {
                [self setImageForBubbleColor:self.selectedBubbleColor];
            }
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideMenuController:) name:UIMenuControllerWillHideMenuNotification object:nil];
        }
    }
}

- (void)tap:(UITapGestureRecognizer *)gestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(tappedImageOfCell:atIndexPath:)] ) {
        [self.delegate tappedImageOfCell:self atIndexPath:[[self tableView] indexPathForCell:self]];
    }
}

#pragma mark - UIMenuController methods

- (BOOL)canPerformAction:(SEL)selector withSender:(id)sender {
    if (selector == @selector(copy:)) {
        return YES;
    }
    
    return NO;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)copy:(id)sender {
    [[UIPasteboard generalPasteboard]setString: self.textLabel.text];
}

- (void)willHideMenuController:(NSNotificationCenter *)notification {
    [self setImageForBubbleColor:self.bubbleColor];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
}

@end
