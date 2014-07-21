//
//  ChatterCell.h
//  EventChat
//
//  Created by Jianchen Tao on 7/8/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatterCell;

@protocol ChatterCellDelegate <NSObject>

-(void)cellDidSelectDelete:(ChatterCell *)cell;
-(void)cellDidSelectMore:(ChatterCell *)cell;

@end

extern NSString *const TLSwipeForOptionsCellEnclosingTableViewDidBeginScrollingNotification;

@interface ChatterCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *chatterName;

@property (nonatomic, weak) id<ChatterCellDelegate> delegate;

@end
