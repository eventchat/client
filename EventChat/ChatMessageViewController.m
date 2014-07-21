//
//  ChatMessageViewController.m
//  EventChat
//
//  Created by Jianchen Tao on 7/8/14.
//  Copyright (c) 2014 EventChat. All rights reserved.
//

#import "ChatMessageViewController.h"
#import "ChatMessageCell.h"
#import "ChatMessage.h"

@interface ChatMessageViewController ()
@property (nonatomic, strong) NSMutableArray *messages;
@end

@implementation ChatMessageViewController

@synthesize messageTable = _messageTable;
@synthesize sendMessage = _sendMessage;
@synthesize sendImage = _sendImage;
@synthesize textField = _textField;

CGRect keyboardSuperFrame;
UIView *keyboardSuperView;
bool keyboardIsShown;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        NSLog(@"initialize for tableview");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     [ChatMessage messageWithString:@"How is that bubble component of yours coming along?" image:[UIImage imageNamed:@"placeholder"]],
                     [ChatMessage messageWithString:@"Great, I just finished avatar support." image:[UIImage imageNamed:@"placeholder"]],
                     [ChatMessage messageWithString:@"That is awesome! blahblahblahblahblahblahblahblah!!!!!!!!! I hope people will like that addition." image:[UIImage imageNamed:@"placeholder"]],
                     [ChatMessage messageWithString:@"Now you see me.." image:[UIImage imageNamed:@"placeholder"]],
                     [ChatMessage messageWithString:@"And now you don't. :)"],
                     nil];
    
    
    self.messageTable.backgroundColor = [UIColor whiteColor];
	self.messageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    // keyboard observer registration
    keyboardIsShown = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    // button observer registration
    [self.sendMessage addTarget:self action:@selector(sendPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDatasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MessageCell";
    
    ChatMessageCell *cell = (ChatMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ChatMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.backgroundColor = self.messageTable.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.dataSource = self.messageTable;
        cell.delegate = self.messageTable;
    }
    
    ChatMessage *message = [self.messages objectAtIndex:indexPath.row];

    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.text = message.message;
    cell.imageView.image = message.avatar;
    
    // Put logic here to determine the author
    if (indexPath.row %2 != 0 ||indexPath.row == 4) {
        cell.authorType = ChatMessageCellAuthorTypeSelf;
        cell.bubbleColor = ChatMessageCellBubbleColorGreen;
    }
    else {
        cell.authorType = ChatMessageCellAuthorTypeOther;
        cell.bubbleColor = ChatMessageCellBubbleColorGray;
    }
    
    return cell;
    
}


#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ChatMessage *message = [self.messages objectAtIndex:indexPath.row];
	
	CGSize size;
	
	if(message.avatar)
    {
		size = [message.message sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(self.messageTable.frame.size.width - [self minInsetForCell:nil atIndexPath:indexPath] - ChatMessageCellBubbleImageSize - 8.0f - ChatMessageCellBubbleWidthOffset, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    }
	else
    {
		size = [message.message sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(self.messageTable.frame.size.width - [self minInsetForCell:nil atIndexPath:indexPath] - ChatMessageCellBubbleWidthOffset, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    }
	
	// This makes sure the cell is big enough to hold the avatar
	if(size.height + 15.0f < ChatMessageCellBubbleImageSize + 4.0f && message.avatar)
    {
		return ChatMessageCellBubbleImageSize + 4.0f;
    }
	
	return size.height + 15.0f;
}

#pragma mark - ChatMessageCellDataSource methods
- (CGFloat) minInsetForCell:(ChatMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        return 100.f;
    }
    else {
        return 50.f;
    }
}

#pragma mark - ChatMessageCellDelegate methods
- (void)tappedImageOfCell:(ChatMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ChatMessage *message = [self.messages objectAtIndex:indexPath.row];
    NSLog(@"%@", message.message);
}

#pragma mark - 
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}


-(void)dismissKeyboard {
    [self.view endEditing:YES];
    
}



#pragma mark - keyboard methods.

- (void)keyboardWillShow:(NSNotification *)notif {
    if (keyboardIsShown) {
        return;
    }
    keyboardIsShown = YES;
    CGRect beginRect = [[notif.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endRect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float margin = beginRect.origin.y - endRect.origin.y;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notif.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notif.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.view.frame = CGRectMake(0, self.view.frame.origin.y - margin, self.view.frame.size.width, self.view.frame.size.height);

    [UIView commitAnimations];
}

- (void) keyboardWillHide:(NSNotification *)notif {
//    if (!keyboardIsShown) {
//        return;
//    }
//    NSLog(@"%@", notif.description);
    keyboardIsShown = NO;
    CGRect beginRect = [[notif.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endRect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float margin = beginRect.origin.y - endRect.origin.y;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notif.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notif.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.view.frame = CGRectMake(0, self.view.frame.origin.y - margin, self.view.frame.size.width, self.view.frame.size.height);

    [UIView commitAnimations];
}

#pragma mark - send message / image button methods

- (void) sendPressed:(id)sender {
//    NSLog(@"send button pressed!"); //debug purpose
    
    [self dismissKeyboard]; //dismiss keyboard
    
    // text processing
    ChatMessage *newMessage = [ChatMessage messageWithString:self.textField.text image:[UIImage imageNamed:@"placeholder"]];
    self.textField.text = @"";  // clear text field

    [self.messages addObject:newMessage];
    [self refreshDisplay:self.messageTable atLastRow:[self.messages count]];
}


#pragma mark - refresh UI methods
- (void)refreshDisplay:(UITableView *)tableView atLastRow:(NSInteger) lastRow{
    [tableView reloadData];
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messages count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


@end
