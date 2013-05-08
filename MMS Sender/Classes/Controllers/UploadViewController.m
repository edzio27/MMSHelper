//
//  UploadViewController.m
//  dysk
//
//  Created by Maciej Gad on 18.02.2013.
//  Copyright (c) 2013 Droids on Roids. All rights reserved.
//

#import "UploadViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ImageRollViewController.h"

@interface UploadViewController () {
    NSMutableArray *assets;
    ALAssetsLibrary *library;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) NSMutableArray *assets;
@property (nonatomic, strong) UIBarButtonItem *edit;
@property (nonatomic, strong) NSMutableArray *selectedImages;

@end

@implementation UploadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableArray *)selectedImages {
    if(_selectedImages == nil) {
        _selectedImages = [[NSMutableArray alloc] init];
    }
    return _selectedImages;
}

- (UIBarButtonItem *)edit {
    if(_edit == nil) {
        _edit = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(uploadAllSelectedImages)];
        _edit.enabled = NO;
    }
    return _edit;
}

- (void)uploadAllSelectedImages {
    [self.selectedImages removeAllObjects];
}

- (void)updateEditButton {
    if(self.selectedImages.count > 0) {
        self.edit.enabled = YES;
    } else {
        self.edit.enabled = NO;
    }
}

#pragma mark tableView methods

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height
                                                                   - self.navigationController.navigationBar.frame.size.height
                                                                   - self.tabBarController.tabBar.frame.size.height
                                                                   - 34)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"number of cell %d", [assets count]);
    return [assets count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ALAssetsGroup *group = (ALAssetsGroup*)[assets objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ ",[group valueForProperty:ALAssetsGroupPropertyName]];
    cell.textLabel.textColor = [UIColor whiteColor];
    [cell.imageView setImage:[UIImage imageWithCGImage:[(ALAssetsGroup*)[assets objectAtIndex:indexPath.row] posterImage]]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ALAssetsGroup *selectedAsset = (ALAssetsGroup*)[assets objectAtIndex:indexPath.row];
    ImageRollViewController *roll = [[ImageRollViewController alloc] initWithNibName:@"ImageRollViewController" bundle:[NSBundle mainBundle] ALAssetsGroup:selectedAsset];
    [self.navigationController pushViewController:roll animated:YES];
}

#pragma end

- (void)loadAlbumsFromGallery {
    // Group enumerator Block
    dispatch_async(dispatch_get_main_queue(), ^{
        // Group enumerator Block
        void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
        {
            if (group == nil)
            {
                return;
            }
            [assets addObject:group];
            
            // Reload albums
            [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
        };
        
        // Group Enumerator Failure Block
        void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            
            NSLog(@"A problem occured %@", [error description]);
        };
        
        // Enumerate Albums
        [library enumerateGroupsWithTypes:ALAssetsGroupAll
                               usingBlock:assetGroupEnumerator
                             failureBlock:assetGroupEnumberatorFailure];
    });
}

- (void)reloadTableView {
    [self.tableView reloadData];
}

#pragma mark ALAsset methods

#pragma end

- (void)viewWillAppear:(BOOL)animated {
    [self updateEditButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.navigationItem.title = @"Select roll";
    [self.navigationItem setRightBarButtonItem:self.edit];
    
    /* title label */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 100, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.525 green:0.518 blue:0.969 alpha:1.0];
    label.text = @"Select roll";
    self.navigationItem.titleView = label;
    
    /* custom back button */
    UIView *buttonHoler = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    UIButton *backButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [backButton setBackgroundImage: [UIImage imageNamed: @"buttonBack.png"]  forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:0.525 green:0.518 blue:0.969 alpha:1.0] forState: UIControlStateNormal];
    [backButton setTitle: NSLocalizedString(@"Back", nil) forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize: 13];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setFrame:CGRectMake(0, 2, 60, 34)];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0);
    backButton.titleLabel.textAlignment = UITextAlignmentCenter;
    [buttonHoler addSubview: backButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: buttonHoler];
    
    
    assets = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableView];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.assets = tempArray;
    
    library = [[ALAssetsLibrary alloc] init];
    [self loadAlbumsFromGallery];
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
