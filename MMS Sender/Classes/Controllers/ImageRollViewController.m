//
//  ImageRollViewController.m
//  dysk
//
//  Created by Eugeniusz Keptia on 05.03.2013.
//  Copyright (c) 2013 Droids on Roids. All rights reserved.
//

#import "ImageRollViewController.h"
#import "ImageGalleryCell.h"
#import "UIImage+ScaleImage.h"
#import "EKMMSSenderViewController.h"

#define NUMBER_OF_IMAGES_IN_ROW 4

@interface ImageRollViewController () {
    ALAssetsGroup *assetGroup;
    NSMutableArray *mutableAssets;
    UIImageView *itemToAdd;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) ALAssetsGroup *assetGroup;
@property (nonatomic, strong) NSMutableArray *mutableAssets;
@property (nonatomic, strong) NSMutableArray *selectedImages;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *grayImageView;
@property (nonatomic, strong) UIBarButtonItem *edit;

@end

@implementation ImageRollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ALAssetsGroup:(ALAssetsGroup *)inputAssetGroup;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.assetGroup = inputAssetGroup;
        // Custom initialization
    }
    return self;
}

- (UIBarButtonItem *)edit {
    if(_edit == nil) {
        _edit = [[UIBarButtonItem alloc] initWithTitle:@"Wgraj" style:UIBarButtonItemStylePlain target:self action:@selector(uploadAllSelectedImages)];
        _edit.enabled = NO;
    }
    return _edit;
}

- (UIImageView *)imageView {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 45, 21, 21)];
    [_imageView setImage:[UIImage imageNamed:@"box-checked"]];
    return _imageView;
}

- (UIImageView *)grayImageView {
    _grayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 45, 21, 21)];
    [_grayImageView setImage:[UIImage imageNamed:@"check-box-list"]];
    return _grayImageView;
}

- (NSMutableArray *)selectedImages {
    if(_selectedImages == nil) {
        _selectedImages = [[NSMutableArray alloc] init];
    }
    return _selectedImages;
}

#pragma mark tableView methods

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 12, 320, [UIScreen mainScreen].bounds.size.height
                                                                   - self.navigationController.navigationBar.frame.size.height
                                                                   - self.tabBarController.tabBar.frame.size.height
                                                                   - 44)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ceil((double) self.mutableAssets.count/NUMBER_OF_IMAGES_IN_ROW);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"cellIdentifier";
    ImageGalleryCell *cell = (ImageGalleryCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[ImageGalleryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.image1.tag = NUMBER_OF_IMAGES_IN_ROW * indexPath.row;
    cell.image2.tag = NUMBER_OF_IMAGES_IN_ROW * indexPath.row + 1;
    cell.image3.tag = NUMBER_OF_IMAGES_IN_ROW * indexPath.row + 2;
    cell.image4.tag = NUMBER_OF_IMAGES_IN_ROW * indexPath.row + 3;
    
    if (self.mutableAssets.count > NUMBER_OF_IMAGES_IN_ROW * indexPath.row) {
        [cell.image1 addSubview:self.grayImageView];
        if([self isContainObject:[self.mutableAssets objectAtIndex:NUMBER_OF_IMAGES_IN_ROW * indexPath.row]]) {
            [cell.image1 addSubview:self.imageView];
        }
        ALAsset *asset = [self.mutableAssets objectAtIndex:NUMBER_OF_IMAGES_IN_ROW * indexPath.row];
        [cell.image1 setImage:[UIImage imageWithCGImage:[asset thumbnail]] forState:UIControlStateNormal];
        [cell.image1 addTarget:self action:@selector(columnSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.mutableAssets.count > NUMBER_OF_IMAGES_IN_ROW * indexPath.row + 1) {
        [cell.image2 addSubview:self.grayImageView];
        if([self isContainObject:[self.mutableAssets objectAtIndex:NUMBER_OF_IMAGES_IN_ROW * indexPath.row + 1]]) {
            [cell.image2 addSubview:self.imageView];
        }
        ALAsset *asset = [self.mutableAssets objectAtIndex:NUMBER_OF_IMAGES_IN_ROW * indexPath.row + 1];
        [cell.image2 setImage:[UIImage imageWithCGImage:[asset thumbnail]] forState:UIControlStateNormal];
        [cell.image2 addTarget:self action:@selector(columnSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.mutableAssets.count > NUMBER_OF_IMAGES_IN_ROW * indexPath.row + 2) {
        [cell.image3 addSubview:self.grayImageView];
        if([self isContainObject:[self.mutableAssets objectAtIndex:NUMBER_OF_IMAGES_IN_ROW * indexPath.row + 2]]) {
            [cell.image3 addSubview:self.imageView];
        }
        ALAsset *asset = [self.mutableAssets objectAtIndex:NUMBER_OF_IMAGES_IN_ROW * indexPath.row + 2];
        [cell.image3 setImage:[UIImage imageWithCGImage:[asset thumbnail]] forState:UIControlStateNormal];
        [cell.image3 addTarget:self action:@selector(columnSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.mutableAssets.count > NUMBER_OF_IMAGES_IN_ROW * indexPath.row + 3) {
        [cell.image4 addSubview:self.grayImageView];
        if([self isContainObject:[self.mutableAssets objectAtIndex:NUMBER_OF_IMAGES_IN_ROW * indexPath.row + 3]]) {
            [cell.image4 addSubview:self.imageView];
        }
        ALAsset *asset = [self.mutableAssets objectAtIndex:NUMBER_OF_IMAGES_IN_ROW * indexPath.row + 3];
        [cell.image4 setImage:[UIImage imageWithCGImage:[asset thumbnail]] forState:UIControlStateNormal];
        [cell.image4 addTarget:self action:@selector(columnSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self updateEditButton];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80;
}

- (void) columnSelected: (UIButton*) sender
{
    [self selectedImageWIthIndex:[NSNumber numberWithInt:[sender tag]]];
}

- (BOOL) isContainObject:(ALAsset *)asset {
    for (ALAsset *selectedAsset in self.selectedImages) {
        if([asset.defaultRepresentation.url isEqual:selectedAsset.defaultRepresentation.url]) {
            return YES;
        }
    }
    return NO;
}

- (void)updateEditButton {
    if(self.selectedImages.count > 0) {
        self.edit.enabled = YES;
    } else {
        self.edit.enabled = NO;
    }
}

- (void)uploadAllSelectedImages {
    ALAsset *asset = [self.selectedImages objectAtIndex:0];
    NSData *image = [UIImage scaleImage:[NSString stringWithFormat:@"%@", asset.defaultRepresentation.url]];
    EKMMSSenderViewController *mms = [[EKMMSSenderViewController alloc] initWithNibName:@"EKMMSSenderViewController" bundle:nil imageToSemd:image];
    [self.navigationController pushViewController:mms animated:YES];
    [self.selectedImages removeAllObjects];
}

- (void)selectedImageWIthIndex:(NSNumber *)index {
    if([self isContainObject:[self.mutableAssets objectAtIndex:[index intValue]]]) {
        [self.selectedImages removeAllObjects];
        //[self.delegate removeObjectFromImageArray:[self.mutableAssets objectAtIndex:[index intValue]]];
    } else {
        [self.selectedImages removeAllObjects];
        [self.selectedImages addObject:[self.mutableAssets objectAtIndex:[index intValue]]];
        //[self.delegate addObjectToImageArray:[self.mutableAssets objectAtIndex:[index intValue]]];
    }
    [self.tableView reloadData];
}

#pragma end

-(void)preparePhotos {
    
    [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop)
     {
         if(result == nil)
         {
             return;
         }
         [self.mutableAssets addObject:result];
     }];
	[self.tableView reloadData];
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.navigationItem.title = @"Wybierz obraz";
    [self.navigationItem setRightBarButtonItem:self.edit];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    /*
    UIImage *back = [[UIImage imageNamed:@"back" ] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
    UIImage *back_pressed = [[UIImage imageNamed:@"back_pressed"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:back forState:UIControlStateNormal];
    [backButton setBackgroundImage:back_pressed forState:UIControlStateHighlighted];
    
    [backButton setTitle:@"Powrót" forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backButton addTarget:self action:@selector(didTapBackButton) forControlEvents:UIControlEventTouchUpInside];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    backButton.frame = CGRectMake(0.0f, 0.0f, 77.0f, 29.0f);
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    */
    self.mutableAssets = tempArray;
    
    [self.view addSubview:self.tableView];
    [self preparePhotos];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end