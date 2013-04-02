//
//  EKViewController.m
//  MMS Sender
//
//  Created by edzio27 on 18.03.2013.
//  Copyright (c) 2013 edzio27. All rights reserved.
//

#import "EKViewController.h"
#import "UploadViewController.h"
#import "TakePhotoViewController.h"
#import "EKAppDelegate.h"
#import <QuartzCore/QuartzCore.h>


@interface EKViewController ()

@end

@implementation EKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(id)sender {
    EKAppDelegate * delegate  = (EKAppDelegate*) [[UIApplication sharedApplication] delegate];
    [delegate transitionToCamera];
}
- (IBAction)selectImage:(id)sender {
    UploadViewController *image = [[UploadViewController alloc] init];
    [self.navigationController pushViewController:image animated:YES];
}

@end
