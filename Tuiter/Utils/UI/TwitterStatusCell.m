//
//  TwitterStatusCell.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/27/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "TwitterStatusCell.h"

@implementation TwitterStatusCell


-(void) setTwitterStatus:(TwitterStatus *) status {
    
    self.userNameLabel.text = status.user.name;
    self.statusTextLabel.text = status.text;
    
    [self getPictureOnBackground:status.user.profileImageURL];
}

-(void) getPictureOnBackground:(NSString *) pictureURL {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: pictureURL]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            self.userProfilePicture.image = [UIImage imageWithData: data];
        });
    });
}

-(NSString *)reuseIdentifier {
    return @"TwitterStatusCell";
}

@end
