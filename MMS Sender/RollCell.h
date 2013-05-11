//
//  RollCell.h
//  MMS Sender
//
//  Created by Edzio27 Edzio27 on 11.05.2013.
//  Copyright (c) 2013 edzio27. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RollCell : UITableViewCell {
    IBOutlet UIImageView *thumbnailView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *amountLabel;

}

@property (nonatomic, strong) IBOutlet UIImageView *thumbnailView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *amountLabel;

@end
