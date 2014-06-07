//
//  SecondViewController.h
//  EventChat
//
//  Created by Xiaolei Jin on 5/26/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface CreateViewController : UIViewController

@property Post *toCreatePost;
@property User *currentUser;

@end
