//
//  CircularImageView.m
//  Tuiter
//
//  Created by Adheús Rangel on 10/27/15.
//  Copyright © 2015 Adheús Rangel. All rights reserved.
//

#import "CircularImageView.h"

@implementation CircularImageView

-(void)awakeFromNib {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.height / 2;
}

@end
