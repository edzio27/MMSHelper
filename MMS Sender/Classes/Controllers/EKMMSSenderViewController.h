//
//  EKMMSSenderViewController.h
//  MMS Sender
//
//  Created by edzio27 on 18.03.2013.
//  Copyright (c) 2013 edzio27. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface EKMMSSenderViewController : UIViewController <MFMessageComposeViewControllerDelegate>

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil imageToSemd:(NSData *)image;

@property (nonatomic, strong) MFMessageComposeViewController *picker;
@property (nonatomic, strong) NSData *imageToSend;

- (void)sendMMS;

@end
