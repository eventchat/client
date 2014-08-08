//
//  CreatePostViewController.h
//  EventChat
//
//  Created by Lyman Cao on 8/7/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@interface CreatePostViewController : UIViewController<UIActionSheetDelegate,
UINavigationControllerDelegate, UIImagePickerControllerDelegate>



@property Post *toCreatePost;
@property Event *currentEvent;
@end
