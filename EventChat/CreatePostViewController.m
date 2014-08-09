//
//  CreatePostViewController.m
//  EventChat
//
//  Created by Lyman Cao on 8/7/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "CreatePostViewController.h"
#import "Post.h"
#import "AppDelegate.h"
#import "ECData.h"
#import "ApiUtil.h"
#import "AFNetworking.h"
#import "AssetsLibrary/ALAsset.h"

#import "Constants.h"

@interface CreatePostViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addImageBarButton;

@property (strong, nonatomic) IBOutlet UIToolbar *postToolbar;
- (IBAction)addImageClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property BOOL newMedia;
@end

static NSString * const DEFAULT_TITLE = @"New Post";

@implementation CreatePostViewController{
    AppDelegate *appDelegate;
    ECData *appData;
}
@synthesize toCreatePost;
@synthesize currentEvent;
@synthesize addImageBarButton;
@synthesize postToolbar;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appData = appDelegate.mData;
    
    
//    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:FLICKR_KEY sharedSecret:FLICKR_SECRET];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) {
        return;
    }
    NSLog(@"!!current Event: %@", currentEvent);
    if (self.textView.text.length > 0) {
        NSString *currentTimestamp = [ApiUtil generateTimestamp];
        NSLog(@"in create Post timestamp: %@",currentTimestamp);
        self.toCreatePost = [[Post alloc] initWithId:appData.mId withTitle:DEFAULT_TITLE withAuthor:appData.mUser withBody:self.textView.text withPic:nil withCreatedAt:currentTimestamp withComments:[NSMutableArray array] withLikes:[NSMutableArray array] withType:@"text" withEvent:currentEvent];
        [self sendPostToServer];
    }
}

- (void) sendPostToServer{
    NSLog(@"\n\ntoSendPost: %@", toCreatePost);
    
    NSString *createPost = [NSString stringWithString: CREATE_POST];
    NSDictionary *params = @{@"title":toCreatePost.mTitle,
                            @"type":toCreatePost.mType,
                            @"body":toCreatePost.mBody,
                            @"event_id":toCreatePost.mEvent.mId};
    

    NSURLRequest *createPostRequest = [NSURLRequest requestWithMethod:@"POST" url:createPost parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:createPostRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"create post response %@", (NSDictionary *)responseObject);
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         // fail to log in
         NSLog(@"create post err: %@", error);
     }];
    [operation start];
}

- (IBAction)addImageClicked:(id)sender{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = NO;
    }
}
#pragma mark -
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
        
        NSLog(@"image !!!!!! %@",selectedImage);
//        [self sendtoFlickr:selectedImage];
        
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(selectedImage,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void) sendtoFlickr:(UIImage *)imageToPost{
//    
//    FKImageUploadNetworkOperation *uploadOp = [[FlickrKit sharedFlickrKit] uploadImage:imageToPost args:@{} completion:^(NSString *imageID, NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (error) {
//                // oops!
//                NSLog(@"upload to flickr err! %@", error);
//            } else {
//                // Image is now in flickr!
//                NSLog(@"flickr image id: %@", imageID);
//            }
//        });
//    }];
//}
//
//-(void) testFlickrExplore{
//    FlickrKit *fk = [FlickrKit sharedFlickrKit];
//    FKFlickrInterestingnessGetList *interesting = [[FKFlickrInterestingnessGetList alloc] init];
//    [fk call:interesting completion:^(NSDictionary *response, NSError *error) {
//        // Note this is not the main thread!
//        if (response) {
//            NSMutableArray *photoURLs = [NSMutableArray array];
//            for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
//                NSURL *url = [fk photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData];
//                [photoURLs addObject:url];
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                // Any GUI related operations here
//            });
//        }   
//    }];
//}
@end
