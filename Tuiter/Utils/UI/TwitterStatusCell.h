//
//  TwitterStatusCell.h
//  Tuiter
//
//  Created by Adheús Rangel on 10/27/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterStatus.h"
#import "SWTableViewCell.h"

@interface TwitterStatusCell : SWTableViewCell

@property(nonatomic, weak) IBOutlet UIImageView *userProfilePicture;
@property(nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property(nonatomic, weak) IBOutlet UILabel *statusTextLabel;

-(void) setTwitterStatus:(TwitterStatus *) status;

@end
