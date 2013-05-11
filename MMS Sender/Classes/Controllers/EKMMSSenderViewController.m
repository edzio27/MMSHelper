//
//  EKMMSSenderViewController.m
//  MMS Sender
//
//  Created by edzio27 on 18.03.2013.
//  Copyright (c) 2013 edzio27. All rights reserved.
//

#import "EKMMSSenderViewController.h"

@interface EKMMSSenderViewController ()

@end

@implementation EKMMSSenderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil imageToSemd:(NSData *)image;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.imageToSend = image;
        // Custom initialization
    }
    return self;
}

- (MFMessageComposeViewController *)picker {
    if(_picker == nil) {
        _picker = [[MFMessageComposeViewController alloc] init];
    }
    return _picker;
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundClear"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* title label */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 100, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.525 green:0.518 blue:0.969 alpha:1.0];
    label.text = @"Sender";
    self.navigationItem.titleView = label;
    
    
    /* custom back button */
    UIView *buttonHoler = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    UIButton *backButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [backButton setBackgroundImage: [UIImage imageNamed: @"back"]  forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:0.525 green:0.518 blue:0.969 alpha:1.0] forState: UIControlStateNormal];
    [backButton setTitle: NSLocalizedString(@"Back button", nil) forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize: 13];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setFrame:CGRectMake(0, 5, 60, 34)];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0);
    backButton.titleLabel.textAlignment = UITextAlignmentCenter;
    [buttonHoler addSubview: backButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: buttonHoler];
    

    
    [self performSelector:@selector(showAlert) withObject:self afterDelay:0.2];
    // Do any additional setup after loading the view from its nib.
}

- (void)showAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Size changed", @"") message:[NSString stringWithFormat:@"%lu kB", (unsigned long)self.imageToSend.length/1000] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alertView.tag = 111;
    [alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark mms sender

- (void)sendMMS {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSData *imgData = self.imageToSend;
    NSLog(@"data %d", imgData.length);
    
    [pasteboard setData:imgData forPasteboardType:[UIPasteboardTypeListImage objectAtIndex:0]];
        
    NSString *phoneToCall = @"sms:";
    NSString *phoneToCallEncoded = [phoneToCall stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [[NSURL alloc] initWithString:phoneToCallEncoded];
    
    if([MFMessageComposeViewController canSendText]) {
        NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@"Your Email Body"];
        self.picker.messageComposeDelegate = self;
        self.picker.recipients = [NSArray arrayWithObject:@"888141551"];
        [self.picker setBody:emailBody];// your recipient number or self for testing
        self.picker.body = emailBody;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:url];
            [self.navigationController popToRootViewControllerAnimated:NO];
        });
    }
}
#pragma end

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 111) {
        if(buttonIndex == 0) {
            [self sendMMS];
        }
    }
}

@end
