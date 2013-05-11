//
//  UploadViewController.m
//  dysk
//
//  Created by Eugeniusz Keptia on 18.02.2013.
//  Copyright (c) 2013 Edzio27. All rights reserved.
//

#import "UploadViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ImageRollViewController.h"
#import "RollCell.h"
#import <QuartzCore/QuartzCore.h>

@interface UploadViewController () {
    NSMutableArray *assets;
    ALAssetsLibrary *library;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) NSMutableArray *assets;
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

- (void)uploadAllSelectedImages {
    [self.selectedImages removeAllObjects];
}

#pragma mark tableView methods

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, 320, [UIScreen mainScreen].bounds.size.height
                                                                   - self.navigationController.navigationBar.frame.size.height
                                                                   - self.tabBarController.tabBar.frame.size.height
                                                                   - 24)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"number of cell %d", [assets count]);
    return [assets count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"cellIdentifier";
    
    RollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RollCell" owner:nil options:nil];
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[RollCell class]])
            {
                cell = (RollCell *)currentObject;
                break;
            }
        }
    }
    
    /* define background for cell */
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell"]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ALAssetsGroup *group = (ALAssetsGroup*)[assets objectAtIndex:indexPath.row];
    
    /* thumbnail view */
    cell.thumbnailView.image = [UIImage imageWithCGImage:[(ALAssetsGroup*)[assets objectAtIndex:indexPath.row] posterImage]];
    cell.thumbnailView.transform = CGAffineTransformMakeRotation(-M_PI/18);
    cell.thumbnailView.layer.shouldRasterize = YES;
    [cell.thumbnailView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    
    /* label text */
    cell.nameLabel.font = [UIFont boldSystemFontOfSize:18.0];
    cell.nameLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    cell.nameLabel.textAlignment = NSTextAlignmentLeft;
    cell.nameLabel.textColor = [UIColor colorWithRed:0.996 green:0.788 blue:0.027 alpha:1.0];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ ",[group valueForProperty:ALAssetsGroupPropertyName]];
    
    /* amount label */
    cell.amountLabel.font = [UIFont boldSystemFontOfSize:12.0];
    cell.amountLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    cell.amountLabel.textAlignment = NSTextAlignmentLeft;
    cell.amountLabel.textColor = [UIColor grayColor];
    cell.amountLabel.text = [NSString stringWithFormat:@"%d %@", [(ALAssetsGroup*)[assets objectAtIndex:indexPath.row] numberOfAssets], NSLocalizedString(@"Photo amount", @"")];
    
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundClear"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"Select roll", @"");
    
    /* title label */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 100, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.525 green:0.518 blue:0.969 alpha:1.0];
    label.text = NSLocalizedString(@"Select roll", @"");
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
